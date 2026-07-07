import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_config.dart';

/// Инициализирует Supabase, если задана конфигурация. Иначе — no-op
/// (приложение работает офлайн). Ошибку не роняем наружу, чтобы сбой облака
/// не мешал локальной работе.
Future<bool> initSupabase() async {
  if (!SupabaseConfig.isConfigured) return false;
  try {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      // Значение из дашборда Supabase («anon public» / publishable key).
      publishableKey: SupabaseConfig.anonKey,
    );
    return true;
  } catch (e, st) {
    if (kDebugMode) debugPrint('Supabase init failed: $e\n$st');
    return false;
  }
}
