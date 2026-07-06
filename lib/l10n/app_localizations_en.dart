// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'RPG Tracker';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navHabits => 'Habits';

  @override
  String get navSkills => 'Skills';

  @override
  String get navCharacter => 'Hero';

  @override
  String get navSettings => 'Settings';

  @override
  String get onboardWelcomeTitle => 'Welcome, seeker!';

  @override
  String get onboardWelcomeBody =>
      'Turn your tasks, habits and goals into an adventure with XP, gold and gems.';

  @override
  String get onboardSkillsTitle => 'Skill rose';

  @override
  String get onboardSkillsBody =>
      'Level up skill axes — health, sport, study and more. Completed activities grow your hero.';

  @override
  String get onboardBossTitle => 'Defeat bosses';

  @override
  String get onboardBossBody =>
      'Break big goals into steps and damage bosses. Claim rewards from quests and achievements.';

  @override
  String get onboardStart => 'Start the adventure';

  @override
  String get onboardNext => 'Next';

  @override
  String get onboardSkip => 'Skip';
}
