import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sleep_cycle.dart';

/// Сохранённый хронотип пользователя (null — опрос ещё не пройден).
class ChronoTypeNotifier extends AsyncNotifier<ChronoType?> {
  static const _key = 'chronotype_v1';

  @override
  Future<ChronoType?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_key);
    if (index == null || index < 0 || index >= ChronoType.values.length) {
      return null;
    }
    return ChronoType.values[index];
  }

  Future<void> set(ChronoType type) async {
    state = AsyncData(type);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, type.index);
  }
}

final chronoTypeProvider =
    AsyncNotifierProvider<ChronoTypeNotifier, ChronoType?>(
        ChronoTypeNotifier.new);
