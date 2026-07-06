import 'package:shared_preferences/shared_preferences.dart';

/// Хранит факт прохождения онбординга (первый запуск).
class OnboardingService {
  static const _key = 'onboarding_seen_v1';

  static Future<bool> hasSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  static Future<void> markSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}
