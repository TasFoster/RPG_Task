# Синхронизация через Supabase

Приложение — офлайн-first: локальная БД (Drift) является источником истины,
а Supabase используется как облачное хранилище для синхронизации между web и
мобильной версией. Модель разрешения конфликтов — **last-write-wins** по полю
`updated_at` (тумбстоуны `dirty`/`is_deleted` уже есть во всех таблицах).

Все локальные таблицы синхронизируются через **одну** облачную таблицу
`sync_rows`, где каждая строка хранится как JSON. Это даёт одну RLS-политику и
универсальный движок синхронизации.

## 1. Создать таблицу и политики доступа

В панели Supabase → **SQL Editor** → New query — выполнить:

```sql
-- Единое хранилище синхронизируемых строк.
create table if not exists public.sync_rows (
  user_id     uuid        not null references auth.users(id) on delete cascade,
  table_name  text        not null,
  row_id      text        not null,
  updated_at  timestamptz not null,
  is_deleted  boolean     not null default false,
  data        jsonb       not null,
  primary key (user_id, table_name, row_id)
);

-- Быстрая выборка изменений с момента последней синхронизации.
create index if not exists sync_rows_updated_idx
  on public.sync_rows (user_id, updated_at);

-- Row Level Security: пользователь видит и меняет только свои строки.
alter table public.sync_rows enable row level security;

create policy "sync_rows_select" on public.sync_rows
  for select using (auth.uid() = user_id);
create policy "sync_rows_insert" on public.sync_rows
  for insert with check (auth.uid() = user_id);
create policy "sync_rows_update" on public.sync_rows
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "sync_rows_delete" on public.sync_rows
  for delete using (auth.uid() = user_id);
```

## 2. Авторизация

По умолчанию используется вход по **email + пароль**.

- Для быстрого старта в Supabase → **Authentication → Providers → Email**
  можно **выключить** «Confirm email», тогда вход произойдёт сразу после
  регистрации без письма-подтверждения.
- Если оставить подтверждение включённым — после регистрации нужно перейти по
  ссылке из письма.

## 3. Ключи приложения

Ключи передаются при сборке через `--dart-define` и **не коммитятся** в
публичный репозиторий. Локально они лежат в `env.json` (в `.gitignore`):

```json
{
  "SUPABASE_URL": "https://<ваш-проект>.supabase.co",
  "SUPABASE_ANON_KEY": "sb_publishable_..."
}
```

`SUPABASE_ANON_KEY` — это публичный ключ из **Project Settings → API**
(«anon public» / publishable key). Он безопасен в клиенте при включённом RLS.

## 4. Запуск и сборка с синхронизацией

```bash
# Разработка (web)
flutter run -d chrome --dart-define-from-file=env.json

# Разработка (Android)
flutter run -d <device> --dart-define-from-file=env.json

# Release-сборки
flutter build web --release --no-tree-shake-icons --dart-define-from-file=env.json
flutter build apk --release --no-tree-shake-icons --dart-define-from-file=env.json
```

Без `--dart-define-from-file` приложение собирается и работает **офлайн** —
экран «Аккаунт и синхронизация» покажет, что облако не настроено.

## Как это работает

- **Триггеры синхронизации**: при входе в аккаунт, при возврате приложения из
  фона, периодически (каждые 5 минут на переднем плане) и по кнопке
  «Синхронизировать сейчас».
- **Push**: строки с `dirty = 1` выгружаются в `sync_rows` (upsert), затем
  флаг `dirty` снимается локально.
- **Pull**: из `sync_rows` берутся строки с `updated_at` больше момента
  последней синхронизации и применяются локально, если облачная версия новее
  (last-write-wins). Применение идёт в порядке зависимостей внешних ключей.
- **Дефолтные оси** имеют стабильные id (`axis_health` и т.п.), поэтому на
  разных устройствах они сливаются, а не дублируются.

## Смена пользователя на одном устройстве

Сейчас предполагается один аккаунт на установку. При входе под **другим**
аккаунтом сбрасывается точка синхронизации, но локальные данные предыдущего
пользователя не стираются автоматически. Чтобы начать «с чистого листа» под
новым аккаунтом — переустановите приложение или очистите данные приложения.
(Автоматическую очистку при смене пользователя можно добавить отдельно.)
