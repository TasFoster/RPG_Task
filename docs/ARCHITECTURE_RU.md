# Архитектура проекта

## Принципы

1. **Riverpod** для управления состоянием — компайл-тайм безопасность, независимость от `BuildContext`,
   `AsyncValue` для состояний загрузки/ошибки/данных, низкий порог входа.
2. **Feature-first** — код разбит по фичам, каждая самодостаточна и содержит три слоя.
3. **Local-first** — UI работает **только** с локальной БД (Drift). Синхронизация с облаком (Supabase)
   идёт в фоне через отдельный `SyncService`. Приложение всегда откликается мгновенно и работает офлайн.

## Слои внутри фичи

```
features/<feature>/
├─ data/          # DTO, Drift DAO, реализация репозитория, мапперы (DTO ↔ доменная сущность)
├─ domain/        # доменные сущности (freezed), абстрактный интерфейс репозитория
└─ presentation/  # экраны, виджеты, Riverpod-контроллеры (Notifier/AsyncNotifier)
```

Поток данных: `UI → Riverpod Controller → Repository (interface) → DAO (Drift)`.
`SyncService` отдельно наблюдает за таблицей `sync_queue` и таблицами Supabase.

## Структура `lib/`

```
lib/
├─ main.dart              # точка входа
├─ bootstrap.dart         # инициализация Supabase / Drift / уведомлений / timezone до runApp
├─ app/
│  ├─ app.dart            # MaterialApp.router, тема
│  ├─ router/             # go_router: маршруты, guard авторизации
│  └─ theme/              # темы оформления (в т.ч. покупаемые), типографика
├─ core/
│  ├─ config/             # доступ к env-ключам (через --dart-define)
│  ├─ database/           # Drift AppDatabase, таблицы, DAO, подключение (native/web)
│  ├─ sync/               # SyncService, outbox-очередь, конфликт-резолвер
│  ├─ notifications/      # каналы, планировщик, full-screen intent
│  ├─ overlay/            # оверлей поверх экрана (flutter_overlay_window) + entrypoint
│  ├─ focus/              # фокус-режим: foreground_task, блокировка приложений (MethodChannel)
│  └─ gamification/       # движок XP/валюты/уровней/стриков (чистые функции) + balance.dart
├─ features/             # auth, tasks, habits, goals, skills, rewards, quests,
│                        # achievements, character, pomodoro, social, stats, settings
└─ shared/               # переиспользуемые виджеты, диалоги
```

## Синхронизация (офлайн-first)

- У всех сущностей **client-generated UUID** — не зависим от серверных autoincrement.
- Служебные поля: `id`, `user_id`, `updated_at`, `is_deleted` (тумбстоун), `dirty`, `version`.
- **Разрешение конфликтов — гибрид:**
  - *Состояние* (задача, привычка, персонаж, настройки) → **last-write-wins** по `updated_at`.
  - *Начисления* (валюта, XP, отметки выполнения) → **append-only event log**, не перезаписываются;
    итог суммирует сервер. Это исключает потерю и задвоение валюты.
- **Outbox:** локальная таблица `sync_queue`. При появлении сети: push исходящих → pull изменений
  (`updated_at > cursor`) → merge. Realtime-подписка Supabase обновляет Drift при изменениях с других устройств.
- **Античит:** финальное начисление XP/валюты подтверждает серверная **Edge Function** по event log.

## Безопасность (RLS)

Все таблицы Supabase: включён Row Level Security, политика `user_id = auth.uid()`.
Лидерборды отдаются через `security definer` представления/функции (только публичные поля).

## Платформенная изоляция

Оверлей и жёсткая блокировка приложений — только Android. Прячутся за проверками `Platform.isAndroid`;
UI грациозно скрывает недоступные на других платформах функции.
