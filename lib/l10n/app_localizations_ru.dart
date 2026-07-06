// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'RPG Трекер';

  @override
  String get navTasks => 'Задачи';

  @override
  String get navHabits => 'Привычки';

  @override
  String get navSkills => 'Навыки';

  @override
  String get navCharacter => 'Герой';

  @override
  String get navSettings => 'Настройки';

  @override
  String get onboardWelcomeTitle => 'Добро пожаловать, искатель!';

  @override
  String get onboardWelcomeBody =>
      'Превратите задачи, привычки и цели в приключение с опытом, золотом и кристаллами.';

  @override
  String get onboardSkillsTitle => 'Роза навыков';

  @override
  String get onboardSkillsBody =>
      'Прокачивайте оси навыков — здоровье, спорт, учёбу и другие. Выполненные дела растят вашего героя.';

  @override
  String get onboardBossTitle => 'Победите боссов';

  @override
  String get onboardBossBody =>
      'Разбивайте большие цели на шаги и наносите урон боссам. Забирайте награды за квесты и достижения.';

  @override
  String get onboardStart => 'Начать приключение';

  @override
  String get onboardNext => 'Далее';

  @override
  String get onboardSkip => 'Пропустить';
}
