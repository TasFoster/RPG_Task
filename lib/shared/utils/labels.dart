import '../../core/gamification/balance.dart';
import '../../core/models/enums.dart';

String difficultyLabel(Difficulty d) => switch (d) {
      Difficulty.easy => 'Лёгкая',
      Difficulty.medium => 'Средняя',
      Difficulty.hard => 'Тяжёлая',
      Difficulty.auto => 'Авто',
    };

String frequencyLabel(Frequency f) => switch (f) {
      Frequency.daily => 'Ежедневно',
      Frequency.weekly => 'Еженедельно',
      Frequency.rare => 'Редко',
    };

String habitTypeLabel(HabitType t) => switch (t) {
      HabitType.positive => 'Полезная',
      HabitType.negative => 'Вредная',
    };
