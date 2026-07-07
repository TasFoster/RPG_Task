import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/database/app_database.dart';
import '../../../shared/widgets/reward_snackbar.dart';
import '../data/sleep_cycle.dart';
import '../data/sleep_prefs.dart';
import '../data/sleep_repository.dart';

String _hm(DateTime t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

String _dur(Duration d) {
  final h = d.inMinutes ~/ 60;
  final m = d.inMinutes % 60;
  return m == 0 ? '$hч' : '$hч $mм';
}

/// Трекер сна: калькулятор циклов, хронотип, дневник и статистика.
class SleepScreen extends ConsumerWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(sleepLogsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Трекер сна')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _editSleep(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Записать сон'),
      ),
      body: logsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
        data: (logs) => ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 96),
          children: [
            const _ChronotypeCard(),
            const SizedBox(height: 12),
            const _CycleCalculatorCard(),
            const SizedBox(height: 12),
            if (logs.isNotEmpty) ...[
              _StatsSection(logs: logs),
              const SizedBox(height: 12),
              _DurationChart(logs: logs),
              const SizedBox(height: 12),
              Text('Дневник сна',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              for (final log in logs) _SleepTile(log: log),
            ] else
              const _EmptyHint(),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────── Хронотип ───────────────────────────

class _ChronotypeCard extends ConsumerWidget {
  const _ChronotypeCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final type = ref.watch(chronoTypeProvider).value;

    if (type == null) {
      return Card(
        child: ListTile(
          leading: const Icon(Icons.nightlight_round),
          title: const Text('Определите свой хронотип'),
          subtitle: const Text('Короткий опрос подберёт окно сна'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/sleep/chronotype'),
        ),
      );
    }

    final w = type.window;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Хронотип: ${type.label}',
                    style: theme.textTheme.titleSmall),
                const Spacer(),
                TextButton(
                  onPressed: () => context.push('/sleep/chronotype'),
                  child: const Text('Пройти заново'),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(type.advice, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(
              'Рекомендуемое окно: ${_min(w.bed)} – ${_min(w.wake)}',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  static String _min(int m) =>
      '${(m ~/ 60 % 24).toString().padLeft(2, '0')}:${(m % 60).toString().padLeft(2, '0')}';
}

// ─────────────────────────── Калькулятор циклов ───────────────────────────

class _CycleCalculatorCard extends StatefulWidget {
  const _CycleCalculatorCard();

  @override
  State<_CycleCalculatorCard> createState() => _CycleCalculatorCardState();
}

class _CycleCalculatorCardState extends State<_CycleCalculatorCard> {
  TimeOfDay _wake = const TimeOfDay(hour: 7, minute: 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final bedOptions = wakeTimesForBed(now);

    final wakeDt = DateTime(now.year, now.month, now.day, _wake.hour, _wake.minute);
    final targetWake = wakeDt.isAfter(now) ? wakeDt : wakeDt.add(const Duration(days: 1));
    final sleepOptions = bedtimesForWake(targetWake);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bedtime, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('Калькулятор циклов сна',
                    style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 4),
            Text('Цикл сна ~90 минут. Просыпаться лучше на границе цикла.',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const Divider(height: 24),
            Text('Если лечь сейчас — вставать в:',
                style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final o in sleepOptionsReversed(bedOptions))
                  _OptionChip(time: _hm(o.time), cycles: o.cycles),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: Text('Чтобы встать в ${_wake.format(context)} — лечь в:',
                      style: theme.textTheme.labelLarge),
                ),
                TextButton.icon(
                  onPressed: () async {
                    final picked = await showTimePicker(
                        context: context, initialTime: _wake);
                    if (picked != null) setState(() => _wake = picked);
                  },
                  icon: const Icon(Icons.schedule, size: 18),
                  label: const Text('Время'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final o in sleepOptions)
                  _OptionChip(time: _hm(o.time), cycles: o.cycles),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Показываем варианты «лечь сейчас» от большего числа циклов к меньшему.
  List<CycleOption> sleepOptionsReversed(List<CycleOption> o) =>
      o.reversed.toList();
}

class _OptionChip extends StatelessWidget {
  final String time;
  final int cycles;
  const _OptionChip({required this.time, required this.cycles});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final good = cycles >= 5;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: (good ? theme.colorScheme.primary : theme.colorScheme.tertiary)
            .withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(time,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Text('$cycles цикла · ${(cycles * 1.5).toStringAsFixed(1)}ч',
              style: theme.textTheme.labelSmall),
        ],
      ),
    );
  }
}

// ─────────────────────────── Статистика ───────────────────────────

class _StatsSection extends StatelessWidget {
  final List<SleepLog> logs;
  const _StatsSection({required this.logs});

  @override
  Widget build(BuildContext context) {
    final recent = logs.take(7).toList();
    final durations =
        recent.map((l) => sleepDuration(l.bedTime, l.wakeTime)).toList();
    final avgMin = durations.isEmpty
        ? 0
        : durations.map((d) => d.inMinutes).reduce((a, b) => a + b) ~/
            durations.length;
    final target = (kTargetSleepHours * 60).round();
    final debtMin = durations.fold<int>(
        0, (acc, d) => acc + (target - d.inMinutes).clamp(0, target));
    final lastNight = sleepDuration(logs.first.bedTime, logs.first.wakeTime);

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.nightlight,
            label: 'Прошлая ночь',
            value: _dur(lastNight),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _StatCard(
            icon: Icons.timelapse,
            label: 'Средний сон (7 дней)',
            value: _dur(Duration(minutes: avgMin)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _StatCard(
            icon: Icons.trending_down,
            label: 'Долг сна',
            value: _dur(Duration(minutes: debtMin)),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatCard(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        child: Column(
          children: [
            Icon(icon, color: theme.colorScheme.primary, size: 24),
            const SizedBox(height: 6),
            Text(value,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(label,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}

/// Простой столбчатый график длительности сна за последние ночи.
class _DurationChart extends StatelessWidget {
  final List<SleepLog> logs;
  const _DurationChart({required this.logs});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recent = logs.take(14).toList().reversed.toList();
    const maxHours = 10.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Длительность сна', style: theme.textTheme.titleSmall),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final l in recent)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: _Bar(
                          ratio: (sleepDuration(l.bedTime, l.wakeTime)
                                      .inMinutes /
                                  60 /
                                  maxHours)
                              .clamp(0.02, 1.0),
                          label: _hm(l.wakeTime).substring(0, 2),
                        ),
                      ),
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

class _Bar extends StatelessWidget {
  final double ratio;
  final String label;
  const _Bar({required this.ratio, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: ratio,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary
                      .withValues(alpha: 0.3 + 0.7 * ratio),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: theme.textTheme.labelSmall),
      ],
    );
  }
}

// ─────────────────────────── Записи ───────────────────────────

class _SleepTile extends ConsumerWidget {
  final SleepLog log;
  const _SleepTile({required this.log});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dur = sleepDuration(log.bedTime, log.wakeTime);
    return Dismissible(
      key: ValueKey(log.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: theme.colorScheme.errorContainer,
        child: Icon(Icons.delete, color: theme.colorScheme.onErrorContainer),
      ),
      onDismissed: (_) =>
          ref.read(sleepRepositoryProvider).deleteSleep(log.id),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: ListTile(
          leading: const Icon(Icons.bedtime_outlined),
          title: Text('${_hm(log.bedTime)} → ${_hm(log.wakeTime)}  ·  ${_dur(dur)}'),
          subtitle: Text(log.note?.isNotEmpty == true
              ? log.note!
              : log.dateKey),
          trailing: log.xpAwarded > 0
              ? Text('+${log.xpAwarded} XP',
                  style: theme.textTheme.labelMedium
                      ?.copyWith(color: theme.colorScheme.primary))
              : null,
          onTap: () => _editSleep(context, ref, existing: log),
        ),
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Icon(Icons.bedtime,
              size: 56,
              color: theme.colorScheme.primary.withValues(alpha: 0.5)),
          const SizedBox(height: 12),
          Text('Ещё нет записей сна', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text('Нажмите «Записать сон», чтобы начать',
              style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

// ─────────────────────────── Диалог добавления/правки ───────────────────────────

Future<void> _editSleep(
  BuildContext context,
  WidgetRef ref, {
  SleepLog? existing,
}) async {
  final now = DateTime.now();
  final yesterday = now.subtract(const Duration(days: 1));
  var bed = existing?.bedTime ??
      DateTime(yesterday.year, yesterday.month, yesterday.day, 23, 0);
  var wake = existing?.wakeTime ?? DateTime(now.year, now.month, now.day, 7, 0);
  var note = existing?.note ?? '';

  final saved = await showDialog<bool>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          Future<void> pick(bool isBed) async {
            final base = isBed ? bed : wake;
            final date = await showDatePicker(
              context: context,
              initialDate: base,
              firstDate: DateTime(now.year - 1),
              lastDate: DateTime(now.year + 1),
            );
            if (date == null || !context.mounted) return;
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(base),
            );
            if (time == null) return;
            final dt =
                DateTime(date.year, date.month, date.day, time.hour, time.minute);
            setState(() {
              if (isBed) {
                bed = dt;
              } else {
                wake = dt;
              }
            });
          }

          final dur = sleepDuration(bed, wake);
          return AlertDialog(
            title: Text(existing == null ? 'Запись сна' : 'Правка записи'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.bedtime),
                  title: const Text('Лёг'),
                  trailing: Text('${bed.day}.${bed.month} ${_hm(bed)}'),
                  onTap: () => pick(true),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.wb_sunny),
                  title: const Text('Встал'),
                  trailing: Text('${wake.day}.${wake.month} ${_hm(wake)}'),
                  onTap: () => pick(false),
                ),
                const SizedBox(height: 4),
                Text('Итого сна: ${_dur(dur)}',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: note,
                  decoration: const InputDecoration(
                    labelText: 'Заметка (необязательно)',
                    isDense: true,
                  ),
                  onChanged: (v) => note = v,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Отмена'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Сохранить'),
              ),
            ],
          );
        },
      );
    },
  );

  if (saved != true) return;
  final repo = ref.read(sleepRepositoryProvider);
  if (existing == null) {
    final reward = await repo.addSleep(
        bed: bed, wake: wake, note: note.isEmpty ? null : note);
    if (context.mounted) showRewardSnackBar(context, reward);
  } else {
    await repo.updateSleep(
        id: existing.id, bed: bed, wake: wake, note: note.isEmpty ? null : note);
  }
}
