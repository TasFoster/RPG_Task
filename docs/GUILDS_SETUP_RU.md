# Гильдии — настройка Supabase

Гильдии позволяют объединяться с друзьями/коллегами и видеть общий
рейтинг участников (уровень, престиж, опыт). Данные гильдий живут только в
облаке (Supabase) — офлайн раздел недоступен.

## Как включить

1. Откройте [дашборд Supabase](https://supabase.com/dashboard) → проект →
   **SQL Editor**.
2. Вставьте и выполните целиком скрипт ниже.
3. Готово — раздел «Гильдии» в приложении заработает (Герой → Гильдии).

## SQL-скрипт

```sql
-- ============ Таблицы ============

create table if not exists public.guilds (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(trim(name)) between 1 and 40),
  invite_code text not null unique,
  owner_id uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists public.guild_members (
  guild_id uuid not null references public.guilds(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  display_name text not null default 'Искатель приключений',
  level int not null default 1,
  prestige int not null default 0,
  lifetime_xp bigint not null default 0,
  season_xp bigint not null default 0,
  joined_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (guild_id, user_id)
);

alter table public.guilds enable row level security;
alter table public.guild_members enable row level security;

-- ============ Вспомогательная функция ============
-- security definer обходит RLS внутри самой проверки — иначе политики
-- guild_members ссылались бы сами на себя (рекурсия).

create or replace function public.is_guild_member(gid uuid)
returns boolean
language sql security definer set search_path = public as $$
  select exists(
    select 1 from guild_members
    where guild_id = gid and user_id = auth.uid()
  );
$$;

-- ============ Политики RLS ============

drop policy if exists "guilds: members can read" on public.guilds;
create policy "guilds: members can read" on public.guilds
  for select using (public.is_guild_member(id));

drop policy if exists "guild_members: members can read" on public.guild_members;
create policy "guild_members: members can read" on public.guild_members
  for select using (public.is_guild_member(guild_id));

-- Свою строку участника можно обновлять (публикация уровня/опыта).
drop policy if exists "guild_members: update own" on public.guild_members;
create policy "guild_members: update own" on public.guild_members
  for update using (user_id = auth.uid());

-- Создание гильдии и вступление — ТОЛЬКО через RPC-функции ниже
-- (insert-политик нет намеренно).

-- ============ RPC-функции ============

-- Создать гильдию: генерирует код приглашения, создаёт гильдию и членство.
create or replace function public.create_guild(p_name text)
returns json
language plpgsql security definer set search_path = public as $$
declare
  v_code text;
  v_id uuid;
begin
  if auth.uid() is null then
    raise exception 'Требуется вход в аккаунт';
  end if;
  if char_length(trim(p_name)) < 1 or char_length(trim(p_name)) > 40 then
    raise exception 'Название: от 1 до 40 символов';
  end if;
  -- Код приглашения: 6 символов, повторяем при коллизии.
  loop
    v_code := upper(substring(md5(random()::text) from 1 for 6));
    exit when not exists(select 1 from guilds where invite_code = v_code);
  end loop;
  insert into guilds(name, invite_code, owner_id)
    values (trim(p_name), v_code, auth.uid())
    returning id into v_id;
  insert into guild_members(guild_id, user_id)
    values (v_id, auth.uid());
  return json_build_object('id', v_id, 'name', trim(p_name),
                           'invite_code', v_code);
end $$;

-- Вступить в гильдию по коду приглашения.
create or replace function public.join_guild(p_code text)
returns json
language plpgsql security definer set search_path = public as $$
declare
  v_guild guilds%rowtype;
begin
  if auth.uid() is null then
    raise exception 'Требуется вход в аккаунт';
  end if;
  select * into v_guild from guilds
    where invite_code = upper(trim(p_code));
  if not found then
    raise exception 'Гильдия с таким кодом не найдена';
  end if;
  insert into guild_members(guild_id, user_id)
    values (v_guild.id, auth.uid())
    on conflict (guild_id, user_id) do nothing;
  return json_build_object('id', v_guild.id, 'name', v_guild.name);
end $$;

-- Покинуть гильдию. Если уходит владелец — гильдия передаётся самому
-- раннему участнику; если участников не осталось — удаляется.
create or replace function public.leave_guild(p_guild uuid)
returns void
language plpgsql security definer set search_path = public as $$
declare
  v_owner uuid;
  v_next uuid;
begin
  if auth.uid() is null then
    raise exception 'Требуется вход в аккаунт';
  end if;
  delete from guild_members
    where guild_id = p_guild and user_id = auth.uid();
  select owner_id into v_owner from guilds where id = p_guild;
  if v_owner = auth.uid() then
    select user_id into v_next from guild_members
      where guild_id = p_guild order by joined_at limit 1;
    if v_next is null then
      delete from guilds where id = p_guild;
    else
      update guilds set owner_id = v_next where id = p_guild;
    end if;
  end if;
end $$;

grant execute on function public.is_guild_member(uuid) to authenticated;
grant execute on function public.create_guild(text) to authenticated;
grant execute on function public.join_guild(text) to authenticated;
grant execute on function public.leave_guild(uuid) to authenticated;
```

## Как это работает

- **Приватность:** списки гильдий и участников видят только члены гильдии
  (RLS). Вступление — только по коду приглашения.
- **Код приглашения** показывается в карточке гильдии — отправьте его
  друзьям (кнопка копирования).
- **Показатели участников** (имя, уровень, престиж, опыт) публикуются
  автоматически при открытии раздела «Гильдии».
- **Выход владельца:** гильдия передаётся самому раннему участнику,
  последний вышедший удаляет гильдию.
