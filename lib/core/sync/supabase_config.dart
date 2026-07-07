/// Конфигурация Supabase. Значения передаются при сборке через --dart-define,
/// чтобы не хранить их в публичном репозитории:
///
///   flutter run --dart-define=SUPABASE_URL=https://xxx.supabase.co \
///               --dart-define=SUPABASE_ANON_KEY=eyJ...
///
/// anon key — публичный ключ (безопасен в клиенте при включённом RLS).
/// Если конфигурация не задана — синхронизация выключена, приложение работает
/// полностью офлайн (как раньше).
class SupabaseConfig {
  const SupabaseConfig._();

  static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  /// Задана ли конфигурация облака.
  static bool get isConfigured => url.isNotEmpty && anonKey.isNotEmpty;
}
