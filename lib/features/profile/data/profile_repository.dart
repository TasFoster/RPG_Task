import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/seed.dart';

/// Доступ к профилю игрока (единственная строка).
class ProfileRepository {
  final AppDatabase db;
  ProfileRepository(this.db);

  Stream<Profile?> watchProfile() {
    return (db.select(db.profiles)..where((p) => p.id.equals(kProfileId)))
        .watchSingleOrNull();
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(databaseProvider));
});

final profileStreamProvider = StreamProvider<Profile?>((ref) {
  return ref.watch(profileRepositoryProvider).watchProfile();
});
