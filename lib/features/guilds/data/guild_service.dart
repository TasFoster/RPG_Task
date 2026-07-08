import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/seed.dart';
import '../../../core/gamification/gamification_engine.dart';
import '../../../core/sync/supabase_config.dart';

/// Гильдия, в которой состоит пользователь.
class GuildInfo {
  final String id;
  final String name;
  final String inviteCode;
  final String ownerId;

  const GuildInfo({
    required this.id,
    required this.name,
    required this.inviteCode,
    required this.ownerId,
  });

  factory GuildInfo.fromRow(Map<String, dynamic> row) => GuildInfo(
        id: row['id'] as String,
        name: row['name'] as String,
        inviteCode: row['invite_code'] as String,
        ownerId: row['owner_id'] as String,
      );
}

/// Участник гильдии (публикуемые показатели героя).
class GuildMember {
  final String userId;
  final String displayName;
  final int level;
  final int prestige;
  final int lifetimeXp;
  final int seasonXp;

  const GuildMember({
    required this.userId,
    required this.displayName,
    required this.level,
    required this.prestige,
    required this.lifetimeXp,
    required this.seasonXp,
  });

  factory GuildMember.fromRow(Map<String, dynamic> row) => GuildMember(
        userId: row['user_id'] as String,
        displayName: (row['display_name'] as String?) ?? 'Герой',
        level: (row['level'] as num?)?.toInt() ?? 1,
        prestige: (row['prestige'] as num?)?.toInt() ?? 0,
        lifetimeXp: (row['lifetime_xp'] as num?)?.toInt() ?? 0,
        seasonXp: (row['season_xp'] as num?)?.toInt() ?? 0,
      );
}

/// Ошибка «гильдии не настроены в облаке» (таблицы/функции не созданы).
class GuildsNotConfigured implements Exception {
  @override
  String toString() =>
      'Гильдии не настроены в облаке: выполните SQL-скрипт из '
      'docs/GUILDS_SETUP_RU.md в дашборде Supabase.';
}

/// Доступ к гильдиям в Supabase. Данные гильдий живут только в облаке:
/// нужен настроенный Supabase и вход в аккаунт.
class GuildService {
  static const _engine = GamificationEngine();

  bool get isConfigured => SupabaseConfig.isConfigured;

  SupabaseClient get _client => Supabase.instance.client;

  User? get currentUser =>
      isConfigured ? _client.auth.currentUser : null;

  bool get isReady => currentUser != null;

  /// Превращает «таблица/функция не существует» в понятную ошибку настройки.
  Never _rethrow(Object e) {
    if (e is PostgrestException &&
        (e.code == '42P01' || // relation does not exist
            e.code == '42883' || // function does not exist
            (e.message.contains('does not exist')))) {
      throw GuildsNotConfigured();
    }
    if (e is GuildsNotConfigured) throw e;
    throw Exception('Ошибка гильдий: $e');
  }

  /// Гильдии, в которых состоит пользователь (RLS отдаёт только их).
  Future<List<GuildInfo>> myGuilds() async {
    try {
      final rows = await _client
          .from('guilds')
          .select('id, name, invite_code, owner_id')
          .order('created_at');
      return [for (final r in rows) GuildInfo.fromRow(r)];
    } catch (e) {
      _rethrow(e);
    }
  }

  /// Участники гильдии, отсортированные по опыту за всё время.
  Future<List<GuildMember>> members(String guildId) async {
    try {
      final rows = await _client
          .from('guild_members')
          .select()
          .eq('guild_id', guildId)
          .order('lifetime_xp', ascending: false);
      return [for (final r in rows) GuildMember.fromRow(r)];
    } catch (e) {
      _rethrow(e);
    }
  }

  Future<GuildInfo> create(String name) async {
    try {
      final result = await _client.rpc(
        'create_guild',
        params: {'p_name': name},
      );
      final row = Map<String, dynamic>.from(result as Map);
      return GuildInfo(
        id: row['id'] as String,
        name: row['name'] as String,
        inviteCode: row['invite_code'] as String,
        ownerId: currentUser!.id,
      );
    } catch (e) {
      _rethrow(e);
    }
  }

  Future<void> join(String inviteCode) async {
    try {
      await _client.rpc('join_guild', params: {'p_code': inviteCode});
    } catch (e) {
      _rethrow(e);
    }
  }

  Future<void> leave(String guildId) async {
    try {
      await _client.rpc('leave_guild', params: {'p_guild': guildId});
    } catch (e) {
      _rethrow(e);
    }
  }

  /// Публикация своих показателей во все свои гильдии.
  /// Ошибки глотаются: публикация — фоновая, не должна ломать экран.
  Future<void> publishStats({
    required String displayName,
    required int seasonXp,
    required int lifetimeXp,
    required int prestige,
  }) async {
    final user = currentUser;
    if (user == null) return;
    try {
      await _client.from('guild_members').update({
        'display_name': displayName,
        'level': _engine.levelForXp(seasonXp),
        'prestige': prestige,
        'lifetime_xp': lifetimeXp,
        'season_xp': seasonXp,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('user_id', user.id);
    } catch (e) {
      if (kDebugMode) debugPrint('Guilds: publishStats failed: $e');
    }
  }
}

final guildServiceProvider = Provider<GuildService>((ref) => GuildService());

/// Мои гильдии. Перед загрузкой публикует свежие показатели героя.
final myGuildsProvider =
    FutureProvider.autoDispose<List<GuildInfo>>((ref) async {
  final service = ref.watch(guildServiceProvider);
  if (!service.isReady) return const [];
  final db = ref.watch(databaseProvider);
  final profile = await (db.select(db.profiles)
        ..where((p) => p.id.equals(kProfileId)))
      .getSingleOrNull();
  if (profile != null) {
    await service.publishStats(
      displayName: profile.displayName,
      seasonXp: profile.totalXp,
      lifetimeXp: profile.lifetimeXp,
      prestige: profile.prestige,
    );
  }
  return service.myGuilds();
});

/// Участники гильдии по id.
final guildMembersProvider = FutureProvider.autoDispose
    .family<List<GuildMember>, String>((ref, guildId) {
  return ref.watch(guildServiceProvider).members(guildId);
});
