import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../data/guild_service.dart';

/// Экран «Гильдии»: список своих гильдий с рейтингом участников,
/// создание гильдии и вступление по коду приглашения.
class GuildsScreen extends ConsumerWidget {
  const GuildsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(guildServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Гильдии'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Обновить',
            onPressed: () => ref.invalidate(myGuildsProvider),
          ),
        ],
      ),
      body: !service.isConfigured
          ? const _CloudUnavailable(
              message: 'Гильдии работают через облако. Соберите приложение '
                  'с ключами Supabase (env.json), чтобы включить раздел.',
              showAccountButton: false,
            )
          : !service.isReady
              ? const _CloudUnavailable(
                  message: 'Гильдии доступны после входа в аккаунт — '
                      'так друзья увидят ваш прогресс.',
                  showAccountButton: true,
                )
              : const _GuildsBody(),
    );
  }
}

class _GuildsBody extends ConsumerWidget {
  const _GuildsBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final guildsAsync = ref.watch(myGuildsProvider);

    return guildsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => _ErrorState(error: e),
      data: (guilds) => RefreshIndicator(
        onRefresh: () async => ref.invalidate(myGuildsProvider),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
          children: [
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Создать'),
                    onPressed: () => _showCreateDialog(context, ref),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.key),
                    label: const Text('По коду'),
                    onPressed: () => _showJoinDialog(context, ref),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (guilds.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: Column(
                  children: [
                    Icon(
                      Icons.groups,
                      size: 64,
                      color: theme.colorScheme.primary.withValues(alpha: 0.6),
                    ),
                    const SizedBox(height: 16),
                    Text('Вы пока не состоите в гильдиях',
                        style: theme.textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(
                      'Создайте свою или вступите по коду приглашения '
                      'от друга или коллеги',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            else
              for (final guild in guilds) _GuildCard(guild: guild),
          ],
        ),
      ),
    );
  }
}

class _GuildCard extends ConsumerWidget {
  final GuildInfo guild;
  const _GuildCard({required this.guild});

  Future<void> _leave(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Покинуть гильдию?'),
        content: Text('Вы выйдете из «${guild.name}». '
            'Вернуться можно по коду приглашения.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(guildServiceProvider).leave(guild.id);
      ref.invalidate(myGuildsProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final membersAsync = ref.watch(guildMembersProvider(guild.id));
    final myId = ref.watch(guildServiceProvider).currentUser?.id;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.shield, color: AppTheme.guildGold),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    guild.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    switch (value) {
                      case 'refresh':
                        ref.invalidate(guildMembersProvider(guild.id));
                      case 'leave':
                        _leave(context, ref);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'refresh',
                      child: Text('Обновить'),
                    ),
                    const PopupMenuItem(
                      value: 'leave',
                      child: Text('Покинуть гильдию'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Код приглашения: показать друзьям, копируется по тапу.
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () async {
                await Clipboard.setData(
                    ClipboardData(text: guild.inviteCode));
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(const SnackBar(
                        content: Text('Код приглашения скопирован')));
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.key,
                        size: 16, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: 6),
                    Text(
                      'Код: ${guild.inviteCode}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.copy,
                        size: 14, color: theme.colorScheme.onSurfaceVariant),
                  ],
                ),
              ),
            ),
            const Divider(),
            membersAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(12),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Не удалось загрузить участников: $e',
                    style: theme.textTheme.bodySmall),
              ),
              data: (members) => Column(
                children: [
                  for (var i = 0; i < members.length; i++)
                    _MemberTile(
                      member: members[i],
                      place: i + 1,
                      isMe: members[i].userId == myId,
                      isOwner: members[i].userId == guild.ownerId,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final GuildMember member;
  final int place;
  final bool isMe;
  final bool isOwner;

  const _MemberTile({
    required this.member,
    required this.place,
    required this.isMe,
    required this.isOwner,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final medal = switch (place) {
      1 => '🥇',
      2 => '🥈',
      3 => '🥉',
      _ => null,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              medal ?? '$place',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        member.displayName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: isMe ? FontWeight.w700 : null,
                          color: isMe ? theme.colorScheme.primary : null,
                        ),
                      ),
                    ),
                    if (isOwner) ...[
                      const SizedBox(width: 4),
                      Icon(Icons.workspace_premium,
                          size: 14, color: AppTheme.guildGold),
                    ],
                  ],
                ),
                Text(
                  'ур. ${member.level}'
                  '${member.prestige > 0 ? ' · престиж ${member.prestige}' : ''}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${member.lifetimeXp} XP',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CloudUnavailable extends StatelessWidget {
  final String message;
  final bool showAccountButton;
  const _CloudUnavailable({
    required this.message,
    required this.showAccountButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.groups,
              size: 64,
              color: theme.colorScheme.primary.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 16),
            Text(message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium),
            if (showAccountButton) ...[
              const SizedBox(height: 16),
              FilledButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('Войти в аккаунт'),
                onPressed: () => context.push('/account'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends ConsumerWidget {
  final Object error;
  const _ErrorState({required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final notConfigured = error is GuildsNotConfigured;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              notConfigured ? Icons.cloud_off : Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 16),
            Text(
              '$error',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Повторить'),
              onPressed: () => ref.invalidate(myGuildsProvider),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showCreateDialog(BuildContext context, WidgetRef ref) async {
  final controller = TextEditingController();
  final created = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Новая гильдия'),
      content: TextField(
        controller: controller,
        autofocus: true,
        maxLength: 40,
        decoration: const InputDecoration(
          labelText: 'Название',
          hintText: 'Например: Орден продуктивности',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Создать'),
        ),
      ],
    ),
  );

  final name = controller.text.trim();
  controller.dispose();
  if (created != true || name.isEmpty) return;
  try {
    final guild = await ref.read(guildServiceProvider).create(name);
    ref.invalidate(myGuildsProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          content: Text(
              'Гильдия создана! Код приглашения: ${guild.inviteCode}'),
          duration: const Duration(seconds: 5),
        ));
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$e')));
    }
  }
}

Future<void> _showJoinDialog(BuildContext context, WidgetRef ref) async {
  final controller = TextEditingController();
  final joined = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Вступить в гильдию'),
      content: TextField(
        controller: controller,
        autofocus: true,
        textCapitalization: TextCapitalization.characters,
        decoration: const InputDecoration(
          labelText: 'Код приглашения',
          hintText: 'Например: A1B2C3',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Вступить'),
        ),
      ],
    ),
  );

  final code = controller.text.trim();
  controller.dispose();
  if (joined != true || code.isEmpty) return;
  try {
    await ref.read(guildServiceProvider).join(code);
    ref.invalidate(myGuildsProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
            const SnackBar(content: Text('Вы вступили в гильдию!')));
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$e')));
    }
  }
}
