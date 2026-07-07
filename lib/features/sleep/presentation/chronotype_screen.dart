import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/sleep_cycle.dart';
import '../data/sleep_prefs.dart';

class _Question {
  final String text;
  final List<String> options; // индекс = балл 0..3
  const _Question(this.text, this.options);
}

const List<_Question> _questions = [
  _Question('Во сколько бы вы вставали, будь у вас полная свобода?',
      ['5:00–7:00', '7:00–8:00', '8:00–9:30', 'После 10:00']),
  _Question('Когда у вас пик энергии и ясности ума?',
      ['Раннее утро', 'Первая половина дня', 'Вечер', 'Поздний вечер/ночь']),
  _Question('Во сколько вы обычно ложитесь спать?',
      ['До 22:00', '22:00–23:00', '23:00–01:00', 'После 01:00']),
  _Question('Насколько тяжело вставать рано утром?',
      ['Легко', 'Нормально', 'Трудно', 'Очень трудно']),
];

/// Короткий опросник хронотипа (жаворонок/голубь/сова).
class ChronotypeScreen extends ConsumerStatefulWidget {
  const ChronotypeScreen({super.key});

  @override
  ConsumerState<ChronotypeScreen> createState() => _ChronotypeScreenState();
}

class _ChronotypeScreenState extends ConsumerState<ChronotypeScreen> {
  final Map<int, int> _answers = {};

  bool get _complete => _answers.length == _questions.length;

  Future<void> _finish() async {
    final score = _answers.values.fold<int>(0, (a, b) => a + b);
    final type = chronoTypeFromScore(score, _questions.length);
    await ref.read(chronoTypeProvider.notifier).set(type);
    if (mounted) Navigator.of(context).pop(type);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Ваш хронотип')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Ответьте на 4 вопроса, чтобы подобрать оптимальное окно сна.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          for (var q = 0; q < _questions.length; q++)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_questions[q].text,
                        style: theme.textTheme.titleSmall),
                    const SizedBox(height: 4),
                    RadioGroup<int>(
                      groupValue: _answers[q],
                      onChanged: (v) => setState(() => _answers[q] = v!),
                      child: Column(
                        children: [
                          for (var o = 0;
                              o < _questions[q].options.length;
                              o++)
                            RadioListTile<int>(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              title: Text(_questions[q].options[o]),
                              value: o,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _complete ? _finish : null,
            icon: const Icon(Icons.check),
            label: const Text('Определить хронотип'),
          ),
        ],
      ),
    );
  }
}
