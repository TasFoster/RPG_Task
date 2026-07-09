import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';
import '../database/seed.dart';
import '../models/enums.dart';

const _uuid = Uuid();

/// Автокоррекция журнала наград. Неточности (расхождение сумм журнала со
/// счётчиками профиля) появляются из-за старых операций мимо журнала или
/// last-write-wins при синхронизации. Счётчики профиля — источник истины:
/// при расхождении в журнал добавляется корректирующая запись
/// («Корректировка»), чтобы суммы снова сходились.
class LedgerReconciliation {
  final AppDatabase db;
  LedgerReconciliation(this.db);

  /// Сверяет журнал со счётчиками и дописывает корректировки.
  /// Возвращает число добавленных записей (0 — всё сходилось).
  Future<int> reconcile() {
    return db.transaction(() async {
      final profile = await (db.select(db.profiles)
            ..where((p) => p.id.equals(kProfileId)))
          .getSingleOrNull();
      if (profile == null) return 0;

      final rows = await db.customSelect(
        'SELECT kind, SUM(amount) AS total FROM currency_transactions '
        'WHERE is_deleted = 0 GROUP BY kind',
        readsFrom: {db.currencyTransactions},
      ).get();
      final totals = <CurrencyKind, int>{};
      for (final row in rows) {
        final kindIndex = row.data['kind'] as int;
        if (kindIndex < 0 || kindIndex >= CurrencyKind.values.length) continue;
        totals[CurrencyKind.values[kindIndex]] =
            (row.data['total'] as int?) ?? 0;
      }

      final expected = <CurrencyKind, int>{
        CurrencyKind.xp: profile.lifetimeXp,
        CurrencyKind.gold: profile.gold,
        CurrencyKind.gems: profile.gems,
      };

      var added = 0;
      for (final entry in expected.entries) {
        final diff = entry.value - (totals[entry.key] ?? 0);
        if (diff == 0) continue;
        await db.into(db.currencyTransactions).insert(
              CurrencyTransactionsCompanion.insert(
                id: _uuid.v4(),
                kind: entry.key,
                amount: diff,
                reason: RewardReason.manual,
              ),
            );
        added++;
      }
      return added;
    });
  }
}

final ledgerReconciliationProvider = Provider<LedgerReconciliation>((ref) {
  return LedgerReconciliation(ref.watch(databaseProvider));
});
