import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kSoundsEnabledKey = 'sounds_enabled';

/// Звуковые эффекты действий. Файлы — в assets/sounds/ (mixkit.co).
enum AppSound {
  /// Выполнение задачи: фанфары + гонг.
  taskDone,

  /// Выполнение шага цели/босса: удар мечом.
  stepDone,

  /// Босс повержен: аплодисменты + фейерверк.
  bossKilled,

  /// Обычная цель завершена: ликующие фанфары.
  goalDone,

  /// Подтверждение привычки: рыцарский удар по доспеху.
  habitDone,

  /// Новый уровень героя: торжественные фанфары.
  levelUp,

  /// Покупка в магазине: звон монет.
  purchase,

  /// Награда за ежедневный квест.
  questDone,

  /// Достижение разблокировано: победные барабаны.
  achievement,

  /// Помодоро-сессия завершена: колокольчики.
  pomodoroDone,
}

/// Файлы для каждого эффекта (могут проигрываться слоями одновременно)
/// и их громкость.
const Map<AppSound, List<(String, double)>> _soundAssets = {
  AppSound.taskDone: [
    ('sounds/task_fanfare.mp3', 0.9),
    ('sounds/task_gong.mp3', 0.5),
  ],
  AppSound.stepDone: [('sounds/step_sword.mp3', 1.0)],
  AppSound.bossKilled: [
    ('sounds/boss_applause.mp3', 1.0),
    ('sounds/boss_fireworks.mp3', 0.8),
  ],
  AppSound.goalDone: [('sounds/goal_fanfare.mp3', 1.0)],
  AppSound.habitDone: [('sounds/habit_knight.mp3', 1.0)],
  AppSound.levelUp: [('sounds/levelup_fanfare.mp3', 1.0)],
  AppSound.purchase: [('sounds/purchase_coins.mp3', 1.0)],
  AppSound.questDone: [('sounds/quest_done.mp3', 1.0)],
  AppSound.achievement: [('sounds/achievement_drums.mp3', 0.9)],
  AppSound.pomodoroDone: [('sounds/pomodoro_bell.mp3', 1.0)],
};

/// Настройка «Звуки» (вкл/выкл), хранится в SharedPreferences.
class SoundSettings extends Notifier<bool> {
  @override
  bool build() {
    _load();
    return true; // по умолчанию звуки включены
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_kSoundsEnabledKey) ?? true;
    if (saved != state) state = saved;
  }

  Future<void> setEnabled(bool value) async {
    state = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kSoundsEnabledKey, value);
  }
}

final soundsEnabledProvider =
    NotifierProvider<SoundSettings, bool>(SoundSettings.new);

/// Проигрывание коротких звуковых эффектов. Каждый вызов — свой плеер,
/// поэтому эффекты могут накладываться (гонг поверх фанфар и т.п.).
class SoundService {
  final Ref _ref;
  SoundService(this._ref);

  Future<void> play(AppSound sound) async {
    if (!_ref.read(soundsEnabledProvider)) return;
    final layers = _soundAssets[sound] ?? const [];
    for (final (asset, volume) in layers) {
      try {
        final player = AudioPlayer();
        player.onPlayerComplete.listen((_) => player.dispose());
        await player.play(AssetSource(asset), volume: volume);
      } catch (e) {
        // Звук — некритичное украшение: ошибки не роняют действие.
        if (kDebugMode) debugPrint('Sound $asset failed: $e');
      }
    }
  }
}

final soundServiceProvider = Provider<SoundService>((ref) {
  return SoundService(ref);
});
