import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/sync/sync_service.dart';
import '../data/auth_service.dart';

/// Экран «Аккаунт и синхронизация»: вход/регистрация по email и статус.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authServiceProvider);
    final userAsync = ref.watch(authUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Аккаунт и синхронизация')),
      body: !auth.isAvailable
          ? const _NotConfigured()
          : userAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Ошибка: $e')),
              data: (user) =>
                  user == null ? const _AuthForm() : _SignedIn(user: user),
            ),
    );
  }
}

/// Облако не настроено (нет --dart-define с ключами Supabase).
class _NotConfigured extends StatelessWidget {
  const _NotConfigured();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off,
                size: 64,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6)),
            const SizedBox(height: 16),
            Text('Синхронизация не настроена',
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Приложение работает офлайн. Чтобы включить синхронизацию между '
              'устройствами, соберите приложение с ключами Supabase '
              '(--dart-define). См. docs/SUPABASE_RU.md.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

/// Форма входа / регистрации по email и паролю.
class _AuthForm extends ConsumerStatefulWidget {
  const _AuthForm();

  @override
  ConsumerState<_AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<_AuthForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;
  bool _busy = false;
  String? _error;
  String? _info;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.length < 6) {
      setState(() => _error = 'Введите email и пароль (от 6 символов)');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
      _info = null;
    });
    try {
      final auth = ref.read(authServiceProvider);
      if (_isSignUp) {
        await auth.signUp(email: email, password: password);
        // При включённом подтверждении email вход произойдёт после письма.
        setState(() => _info =
            'Аккаунт создан. Если включено подтверждение email — проверьте почту.');
      } else {
        await auth.signIn(email: email, password: password);
      }
    } on Exception catch (e) {
      setState(() => _error = _friendly(e));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _friendly(Object e) {
    final s = e.toString();
    if (s.contains('Invalid login')) return 'Неверный email или пароль';
    if (s.contains('already registered')) {
      return 'Такой email уже зарегистрирован';
    }
    return 'Не удалось: $s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.cloud_sync,
              size: 56, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            _isSignUp ? 'Регистрация' : 'Вход',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'Один аккаунт синхронизирует данные между web и телефоном.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _passwordController,
            obscureText: true,
            autofillHints: const [AutofillHints.password],
            decoration: const InputDecoration(
              labelText: 'Пароль',
              prefixIcon: Icon(Icons.lock_outline),
            ),
            onSubmitted: (_) => _submit(),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(_error!, style: TextStyle(color: theme.colorScheme.error)),
          ],
          if (_info != null) ...[
            const SizedBox(height: 12),
            Text(_info!, style: TextStyle(color: theme.colorScheme.primary)),
          ],
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _busy ? null : _submit,
            child: _busy
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : Text(_isSignUp ? 'Зарегистрироваться' : 'Войти'),
          ),
          TextButton(
            onPressed: _busy
                ? null
                : () => setState(() {
                      _isSignUp = !_isSignUp;
                      _error = null;
                      _info = null;
                    }),
            child: Text(_isSignUp
                ? 'Уже есть аккаунт? Войти'
                : 'Нет аккаунта? Зарегистрироваться'),
          ),
        ],
      ),
    );
  }
}

/// Состояние «пользователь вошёл»: email, кнопка выхода. Блок синхронизации
/// (статус и ручной запуск) добавляется движком синхронизации.
class _SignedIn extends ConsumerWidget {
  final dynamic user;
  const _SignedIn({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final email = (user.email as String?) ?? 'аккаунт';
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(Icons.person, color: theme.colorScheme.primary),
            ),
            title: Text(email),
            subtitle: const Text('Вы вошли — данные синхронизируются'),
          ),
        ),
        const SizedBox(height: 8),
        const SyncStatusCard(),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () async {
            await ref.read(authServiceProvider).signOut();
          },
          icon: const Icon(Icons.logout),
          label: const Text('Выйти из аккаунта'),
        ),
      ],
    );
  }
}

/// Карточка статуса облачной синхронизации + ручной запуск.
class SyncStatusCard extends ConsumerWidget {
  const SyncStatusCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final sync = ref.watch(syncControllerProvider);
    final busy = sync.status == SyncStatus.syncing;

    final (IconData icon, String text, Color color) = switch (sync.status) {
      SyncStatus.syncing => (
          Icons.sync,
          'Синхронизация…',
          theme.colorScheme.primary
        ),
      SyncStatus.success => (
          Icons.cloud_done,
          sync.lastSyncedAt == null
              ? 'Синхронизировано'
              : 'Синхронизировано в ${DateFormat('HH:mm', 'ru').format(sync.lastSyncedAt!)}',
          theme.colorScheme.primary
        ),
      SyncStatus.error => (
          Icons.sync_problem,
          'Ошибка синхронизации',
          theme.colorScheme.error
        ),
      SyncStatus.offline => (
          Icons.cloud_off,
          'Не в сети',
          theme.colorScheme.onSurfaceVariant
        ),
      SyncStatus.idle => (
          Icons.cloud_queue,
          'Готово к синхронизации',
          theme.colorScheme.onSurfaceVariant
        ),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 12),
                Expanded(child: Text(text)),
              ],
            ),
            if (sync.status == SyncStatus.error && sync.error != null) ...[
              const SizedBox(height: 8),
              Text(sync.error!,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.error)),
            ],
            const SizedBox(height: 12),
            Text(
              'Данные синхронизируются автоматически при входе, возврате в '
              'приложение и периодически. Можно запустить вручную.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: busy
                  ? null
                  : () =>
                      ref.read(syncControllerProvider.notifier).syncNow(),
              icon: busy
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.sync),
              label: const Text('Синхронизировать сейчас'),
            ),
            const SizedBox(height: 4),
            TextButton.icon(
              onPressed: busy ? null : () => _confirmForceUpload(context, ref),
              icon: const Icon(Icons.cloud_upload_outlined, size: 18),
              label: const Text('Отправить мои данные в облако'),
            ),
            Text(
              'Если опыт, золото или задачи «потерялись» — откройте это на '
              'устройстве с верными данными и перезалейте их в облако.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  /// Спрашивает подтверждение и делает данные этого устройства основными.
  Future<void> _confirmForceUpload(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Отправить мои данные в облако?'),
        content: const Text(
          'Данные этого устройства станут основными: они перезапишут облако и '
          'подтянутся на другие устройства. Используйте на устройстве, где '
          'данные верные.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Отправить'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(syncControllerProvider.notifier).forceUploadLocal();
    }
  }
}
