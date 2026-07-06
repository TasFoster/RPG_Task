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
            const Icon(Icons.auto_awesome, color: Color(0xFFD4AF37)),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
}
