# RPG Task Tracker

Мобильное приложение-трекер **задач, привычек и целей** в RPG/фэнтези-стиле с геймификацией
(опыт, золото, уровни, стрики, достижения, боссы-цели, персонаж и питомец).

Основная платформа — **Android**, также собирается под **Web**. Написано на Flutter, работает офлайн
(локальная БД на Drift). Интерфейс на русском и английском.

## Документация

Вся проектная документация — в каталоге [`docs/`](docs/):

- [README_RU.md](docs/README_RU.md) — обзор функций и быстрый старт.
- [SETUP_RU.md](docs/SETUP_RU.md) — установка окружения разработки (Windows).
- [ARCHITECTURE_RU.md](docs/ARCHITECTURE_RU.md) — архитектура и структура кода.
- [GAMIFICATION_RU.md](docs/GAMIFICATION_RU.md) — формулы опыта, валют и уровней.
- [PRIVACY_POLICY_RU.md](docs/PRIVACY_POLICY_RU.md) / [EN](docs/PRIVACY_POLICY_EN.md) — политика конфиденциальности.

## Быстрый старт

```powershell
flutter pub get
flutter run                                  # запуск на устройстве/эмуляторе
flutter build apk --release                  # Android release
flutter build web --release --no-tree-shake-icons   # Web release
```

> Web-сборку обязательно запускать с `--no-tree-shake-icons` — иконки задаются динамически из БД.
