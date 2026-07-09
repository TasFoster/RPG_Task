import 'package:drift/drift.dart' show OrderingMode, OrderingTerm;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/gamification/ledger_reconciliation.dart';
import '../../../core/models/enums.dart';
import '../../../shared/utils/labels.dart';
import '../../profile/data/profile_repository.dart';
import '../../shop/data/shop_catalog.dart';

/// Последние транзакции журнала (новые сверху).
final rewardLogProvider = StreamProvider<List<CurrencyTransaction>>((ref) {
  final db = ref.watch(databaseProvider);
  final query = db.select(db.currencyTransactions)
    ..where((t) => t.isDeleted.equals(false))
    ..orderBy([
      (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
    ])
    ..limit(500);
  return query.watch();
});

/// Суммы по журналу (за всё время) для сверки со счётчиками профиля.
final ledgerTotalsProvider = StreamProvider<Map<CurrencyKind, int>>((ref) {
  final db = ref.watch(databaseProvider);
  final query = db.customSelect(
    'SELECT kind, SUM(amount) AS total FROM currency_transactions '
    'WHERE is_deleted = 0 GROUP BY kind',
    readsFrom: {db.currencyTransactions},
  );
  return query.watch().map((rows) {
    final map = <CurrencyKind, int>{};
    for (final row in rows) {
      final kindIndex = row.data['kind'] as int;
      if (kindIndex < 0 || kindIndex >= CurrencyKind.values.length) continue;
      map[CurrencyKind.values[kindIndex]] = (row.data['total'] as int?) ?? 0;
    }
    return map;
  });
});

/// Названия сущностей по id — чтобы показывать, за что была награда.
final _refTitlesProvider = FutureProvider<Map<String, String>>((ref) async {
  final db = ref.watch(databaseProvider);
  final map = <String, String>{};
  for (final row in await db.select(db.tasks).get()) {
    map[row.id] = row.title;
  }
  for (final row in await db.select(db.habits).get()) {
    map[row.id] = row.title;
  }
  for (final row in await db.select(db.goals).get()) {
    map[row.id] = row.title;
  }
  for (final row in await db.select(db.goalSteps).get()) {
    map[row.id] = row.title;
  }
  for (final item in kShopItems) {
    map[item.key] = item.name;
  }
  return map;
});

/// Журнал начислений XP/золота/кристаллов: полная история с фильтром по
/// валюте и сверкой счётчиков профиля с суммами журнала.
class RewardLogScreen extends ConsumerStatefulWidget {
  const RewardLogScreen({super.key});

  @override
  ConsumerState<RewardLogScreen> createState() => _RewardLogScreenState();
}

class _RewardLogScreenState extends ConsumerState<RewardLogScreen> {
  CurrencyKind? _filter; // null — все валюты

  @override
  void initState() {
    super.initState();
    // Неточности журнала закрываются автоматически при открытии экрана.
    Future.microtask(
        () => ref.read(ledgerReconciliationProvider).reconcile());
  }

  @override
  Widget build(BuildContext context) {
    final logAsync = ref.watch(rewardLogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Журнал наград')),
      body: Column(
        children: [
          const _ReconciliationCard(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<CurrencyKind?>(
                showSelectedIcon: false,
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                ),
                segments: const [
                  ButtonSegment(value: null, label: Text('Все')),
                  ButtonSegment(
                    value: CurrencyKind.xp,
                    label: Text('XP'),
                  ),
                  ButtonSegment(
                    value: CurrencyKind.gold,
                    label: Text('Золото'),
                  ),
                  ButtonSegment(
                    value: CurrencyKind.gems,
                    label: Text('💎'),
                  ),
                ],
                selected: {_filter},
                onSelectionChanged: (s) =>
                    setState(() => _filter = s.first),
              ),
            ),
          ),
          Expanded(
            child: logAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Ошибка: $e')),
              data: (txs) {
                final filtered = _filter == null
                    ? txs
                    : txs.where((t) => t.kind == _filter).toList();
                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      'Записей пока нет',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  );
                }
                return _GroupedLog(transactions: filtered);
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Сверка: суммы журнала против текущих счётчиков профиля. Расхождение —
/// признак сбоя подсчёта (или операций, прошедших мимо журнала).
class _ReconciliationCard extends ConsumerWidget {
  const _ReconciliationCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final totals = ref.watch(ledgerTotalsProvider).value;
    final profile = ref.watch(profileStreamProvider).value;
    if (totals == null || profile == null) return const SizedBox.shrink();

    Widget row(String label, int ledger, int actual) {
      final ok = ledger == actual;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Icon(
              ok ? Icons.check_circle : Icons.warning_amber,
              size: 16,
              color: ok ? Colors.green : Colors.amber,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(label, style: theme.textTheme.bodySmall),
            ),
            Text(
              ok ? '$actual' : 'журнал $ledger ≠ счёт $actual',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: ok ? null : Colors.amber.shade800,
              ),
            ),
          ],
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Сверка счётчиков', style: theme.textTheme.titleSmall),
            const SizedBox(height: 6),
            row('Опыт за всё время',
                totals[CurrencyKind.xp] ?? 0, profile.lifetimeXp),
            row('Золото', totals[CurrencyKind.gold] ?? 0, profile.gold),
            row('Кристаллы', totals[CurrencyKind.gems] ?? 0, profile.gems),
            const SizedBox(height: 4),
            Text(
              'Расхождения закрываются автоматически записями «Корректировка».',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupedLog extends ConsumerWidget {
  final List<CurrencyTransaction> transactions;
  const _GroupedLog({required this.transactions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final titles = ref.watch(_refTitlesProvider).value ?? const {};
    final dateFormat = DateFormat('d MMMM yyyy', 'ru');

    // Группировка по дням (список уже отсортирован по убыванию даты).
    final items = <Widget>[];
    DateTime? currentDay;
    for (final tx in transactions) {
      final day = DateTime(
          tx.createdAt.year, tx.createdAt.month, tx.createdAt.day);
      if (currentDay != day) {
        currentDay = day;
        items.add(Padding(
          padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
          child: Text(
            dateFormat.format(day),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ));
      }
      items.add(_TxTile(tx: tx, entityTitle: titles[tx.refEntity]));
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
      children: items,
    );
  }
}

class _TxTile extends StatelessWidget {
  final CurrencyTransaction tx;
  final String? entityTitle;
  const _TxTile({required this.tx, this.entityTitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final positive = tx.amount >= 0;
    final (icon, color) = switch (tx.kind) {
      CurrencyKind.xp => (Icons.bolt, theme.colorScheme.secondary),
      CurrencyKind.gold => (Icons.monetization_on, AppTheme.guildGold),
      CurrencyKind.gems => (Icons.diamond, AppTheme.crystalBlue),
    };
    final time = DateFormat('HH:mm').format(tx.createdAt);
    final subtitle = entityTitle == null || entityTitle!.trim().isEmpty
        ? time
        : '$time · $entityTitle';

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: color),
        title: Text(
          rewardReasonLabel(tx.reason),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          '${positive ? '+' : ''}${tx.amount} ${currencyKindLabel(tx.kind)}',
          style: theme.textTheme.titleSmall?.copyWith(
            color: positive ? Colors.green : theme.colorScheme.error,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
