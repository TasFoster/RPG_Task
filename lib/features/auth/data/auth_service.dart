import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/sync/supabase_config.dart';

/// Доступ к авторизации Supabase (email + пароль). Если Supabase не настроен —
/// [isAvailable] == false, все операции недоступны, приложение офлайн.
class AuthService {
  /// Доступна ли облачная авторизация (задана конфигурация Supabase).
  bool get isAvailable => SupabaseConfig.isConfigured;

  SupabaseClient get _client => Supabase.instance.client;

  User? get currentUser => isAvailable ? _client.auth.currentUser : null;

  bool get isSignedIn => currentUser != null;

  /// Поток состояний авторизации (вход/выход/обновление сессии).
  Stream<AuthState> authStateChanges() =>
      isAvailable ? _client.auth.onAuthStateChange : const Stream.empty();

  Future<void> signUp({required String email, required String password}) async {
    await _client.auth.signUp(email: email, password: password);
  }

  Future<void> signIn({required String email, required String password}) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

/// Текущий пользователь (null — не вошёл или облако не настроено).
/// Пересобирается при каждом изменении состояния авторизации.
final authUserProvider = StreamProvider<User?>((ref) {
  final auth = ref.watch(authServiceProvider);
  if (!auth.isAvailable) return Stream.value(null);
  // Начинаем с текущего пользователя, затем следим за изменениями.
  return auth
      .authStateChanges()
      .map((state) => state.session?.user)
      .startWith(auth.currentUser);
});

extension _StartWith<T> on Stream<T> {
  Stream<T> startWith(T value) async* {
    yield value;
    yield* this;
  }
}
