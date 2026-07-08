import 'package:flutter/material.dart';

import '../../core/gamification/gamification_engine.dart';

/// Показывает всплывающее уведомление о полученной награде.
void showRewardSnackBar(BuildContext context, RewardResult reward) {
  final parts = <String>[];
  if (reward.xp != 0) parts.add('${reward.xp > 0 ? '+' : ''}${reward.xp} XP');
  if (reward.gold != 0) parts.add('+${reward.gold} золота');
  if (reward.gems != 0) parts.add('+${reward.gems} 💎');
  final text = parts.isEmpty ? 'Готово!' : parts.join('   ');

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            // Появление с «вспышкой»: масштаб + поворот иконки награды.
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 450),
              curve: Curves.elasticOut,
              builder: (context, value, child) => Transform.rotate(
                angle: (1 - value) * 0.8,
                child: Transform.scale(scale: value, child: child),
              ),
              child: const Icon(Icons.auto_awesome, color: Color(0xFFD4AF37)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
}
