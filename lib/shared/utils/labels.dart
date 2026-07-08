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

String rewardReasonLabel(RewardReason r) => switch (r) {
      RewardReason.taskCompleted => 'Задача выполнена',
      RewardReason.habitCompleted => 'Привычка выполнена',
      RewardReason.habitFailed => 'Срыв привычки',
      RewardReason.goalStep => 'Шаг цели',
      RewardReason.bossKilled => 'Босс повержен',
      RewardReason.streakBonus => 'Бонус за серию',
      RewardReason.achievement => 'Достижение',
      RewardReason.dailyQuest => 'Ежедневный квест',
      RewardReason.focusSession => 'Фокус-сессия',
      RewardReason.purchase => 'Покупка в магазине',
      RewardReason.manual => 'Корректировка',
      RewardReason.sleepReward => 'Здоровый сон',
      RewardReason.codexComplete => 'Кодекс собран',
      RewardReason.journalEntry => 'Запись в дневнике',
    };

String currencyKindLabel(CurrencyKind k) => switch (k) {
      CurrencyKind.xp => 'XP',
      CurrencyKind.gold => 'Золото',
      CurrencyKind.gems => 'Кристаллы',
    };
