import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Настройки показа советов и цитат. Гибко: отдельные тумблеры для мест показа
/// и время пуш-уведомлений. Хранится в SharedPreferences.
class TipsSettings {
  final bool dailyEnabled; // «Совет дня» на главной
  final bool contextualEnabled; // контекстные подсказки (пустой экран, Помодоро)
  final bool pushMorning; // утренний девиз
  final bool pushEvening; // вечерняя рефлексия
  final int morningMinute; // минута суток [0..1439]
  final int eveningMinute;

  const TipsSettings({
    this.dailyEnabled = true,
    this.contextualEnabled = true,
    this.pushMorning = false, // по умолчанию выключено — не спамим без спроса
    this.pushEvening = false,
    this.morningMinute = 8 * 60, // 08:00
    this.eveningMinute = 22 * 60, // 22:00
  });

  bool get anyPush => pushMorning || pushEvening;

  TipsSettings copyWith({
    bool? dailyEnabled,
    bool? contextualEnabled,
    bool? pushMorning,
    bool? pushEvening,
    int? morningMinute,
    int? eveningMinute,
  }) {
    return TipsSettings(
      dailyEnabled: dailyEnabled ?? this.dailyEnabled,
      contextualEnabled: contextualEnabled ?? this.contextualEnabled,
      pushMorning: pushMorning ?? this.pushMorning,
      pushEvening: pushEvening ?? this.pushEvening,
      morningMinute: morningMinute ?? this.morningMinute,
      eveningMinute: eveningMinute ?? this.eveningMinute,
    );
  }

  /// Загрузка настроек напрямую (для bootstrap, вне Riverpod-контейнера).
  static Future<TipsSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    return _read(prefs);
  }

  static TipsSettings _read(SharedPreferences p) => TipsSettings(
        dailyEnabled: p.getBool('tips_daily') ?? true,
        contextualEnabled: p.getBool('tips_contextual') ?? true,
        pushMorning: p.getBool('tips_push_morning') ?? false,
        pushEvening: p.getBool('tips_push_evening') ?? false,
        morningMinute: p.getInt('tips_morning_minute') ?? 8 * 60,
        eveningMinute: p.getInt('tips_evening_minute') ?? 22 * 60,
      );

  Future<void> _write(SharedPreferences p) async {
    await p.setBool('tips_daily', dailyEnabled);
    await p.setBool('tips_contextual', contextualEnabled);
    await p.setBool('tips_push_morning', pushMorning);
    await p.setBool('tips_push_evening', pushEvening);
    await p.setInt('tips_morning_minute', morningMinute);
    await p.setInt('tips_evening_minute', eveningMinute);
  }
}

class TipsSettingsNotifier extends AsyncNotifier<TipsSettings> {
  @override
  Future<TipsSettings> build() async {
    final prefs = await SharedPreferences.getInstance();
    return TipsSettings._read(prefs);
  }

  Future<void> save(TipsSettings next) async {
    state = AsyncData(next);
    final prefs = await SharedPreferences.getInstance();
    await next._write(prefs);
  }
}

final tipsSettingsProvider =
    AsyncNotifierProvider<TipsSettingsNotifier, TipsSettings>(
        TipsSettingsNotifier.new);
