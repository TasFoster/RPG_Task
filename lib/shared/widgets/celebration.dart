import 'dart:math' as math;

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

/// Масштаб празднования.
enum CelebrationStyle {
  /// Небольшой залп конфетти сверху (цель, уровень, достижение).
  burst,

  /// Полноэкранный «фейерверк»: залпы из углов и центра (босс повержен).
  fireworks,
}

/// Показывает поверх всего приложения анимацию конфетти/фейерверка.
/// Оверлей не перехватывает касания и убирает себя сам.
void showCelebration(BuildContext context,
    {CelebrationStyle style = CelebrationStyle.burst}) {
  final overlay = Overlay.of(context, rootOverlay: true);
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => _CelebrationOverlay(
      style: style,
      onDone: () => entry.remove(),
    ),
  );
  overlay.insert(entry);
}

class _CelebrationOverlay extends StatefulWidget {
  final CelebrationStyle style;
  final VoidCallback onDone;
  const _CelebrationOverlay({required this.style, required this.onDone});

  @override
  State<_CelebrationOverlay> createState() => _CelebrationOverlayState();
}

class _CelebrationOverlayState extends State<_CelebrationOverlay> {
  late final ConfettiController _center;
  late final ConfettiController _left;
  late final ConfettiController _right;
  bool _finished = false;

  static const _festive = [
    Color(0xFFD4AF37), // золото
    Color(0xFFF44336), // красный
    Color(0xFF7C4DFF), // фиолетовый
    Color(0xFF40C4FF), // голубой
    Color(0xFF69F0AE), // зелёный
    Color(0xFFFFAB40), // оранжевый
  ];

  bool get _big => widget.style == CelebrationStyle.fireworks;

  @override
  void initState() {
    super.initState();
    final duration =
        _big ? const Duration(seconds: 3) : const Duration(milliseconds: 1200);
    _center = ConfettiController(duration: duration)..play();
    _left = ConfettiController(duration: duration);
    _right = ConfettiController(duration: duration);
    if (_big) {
      _left.play();
      _right.play();
    }
    // Снимаем оверлей после окончания залпа и падения частиц.
    Future.delayed(duration + const Duration(seconds: 3), () {
      if (mounted && !_finished) {
        _finished = true;
        widget.onDone();
      }
    });
  }

  @override
  void dispose() {
    _center.dispose();
    _left.dispose();
    _right.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          // Центральный «взрыв» — как салют.
          Align(
            alignment: _big ? Alignment.center : Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _center,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: _big ? 0.08 : 0.6,
              numberOfParticles: _big ? 24 : 16,
              maxBlastForce: _big ? 32 : 18,
              minBlastForce: 8,
              gravity: 0.25,
              shouldLoop: false,
              colors: _festive,
            ),
          ),
          if (_big) ...[
            // Пушки из нижних углов — стреляют вверх к центру.
            Align(
              alignment: Alignment.bottomLeft,
              child: ConfettiWidget(
                confettiController: _left,
                blastDirection: -math.pi / 3, // вверх-вправо
                emissionFrequency: 0.12,
                numberOfParticles: 12,
                maxBlastForce: 40,
                minBlastForce: 15,
                gravity: 0.3,
                shouldLoop: false,
                colors: _festive,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ConfettiWidget(
                confettiController: _right,
                blastDirection: -2 * math.pi / 3, // вверх-влево
                emissionFrequency: 0.12,
                numberOfParticles: 12,
                maxBlastForce: 40,
                minBlastForce: 15,
                gravity: 0.3,
                shouldLoop: false,
                colors: _festive,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
