# Установка окружения разработки (Windows 11)

Документ описывает полную настройку окружения с нуля для проекта **RPG Task Tracker**.
Все команды выполняются в **PowerShell**. Установка идёт через `winget` (встроен в Windows 11).

> ⚠️ После установки каждого инструмента, добавляющего себя в `PATH`, **перезапустите терминал**,
> иначе новые команды не будут видны.

## 0. Проверка winget

```powershell
winget --version
```

## 1. Git

```powershell
winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements --silent
```
Проверка (в новом терминале): `git --version`

## 2. JDK 17 (для Android/Gradle)

```powershell
winget install --id Microsoft.OpenJDK.17 -e --silent
```
Проверка: `java -version` → должно быть `17.x`.

## 3. Android Studio (Android SDK + эмулятор)

```powershell
winget install --id Google.AndroidStudio -e --silent
```
Затем запустить Android Studio и:
1. Пройти **Setup Wizard** (Standard) — скачает Android SDK, Platform-Tools, Build-Tools, Emulator, системный образ.
2. **More Actions → SDK Manager → SDK Platforms**: отметить **Android 14 (API 34)** и **Android 15 (API 35)**.
3. **SDK Tools**: отметить *Android SDK Command-line Tools*, *Android SDK Platform-Tools*, *Android Emulator*.

## 4. Flutter SDK

```powershell
winget install --id Flutter.Flutter -e --silent
```
Проверка: `flutter --version`, `dart --version`.

> Альтернатива (ручная): распаковать zip с flutter.dev в `C:\src\flutter` (без пробелов, без прав админа),
> добавить `C:\src\flutter\bin` в переменную PATH.

## 5. VS Code + расширение Flutter

```powershell
winget install --id Microsoft.VisualStudioCode -e --silent
```
В VS Code установить расширение **Flutter** (издатель Dart-Code) — оно подтянет Dart автоматически.

## 6. Принять лицензии Android

```powershell
flutter doctor --android-licenses   # отвечать y на все
```

## 7. (Опционально) Поддержка Windows Desktop

Нужен Visual Studio 2022 (не Code!) с рабочей нагрузкой «Desktop development with C++»:
```powershell
winget install --id Microsoft.VisualStudio.2022.Community -e --silent
```
В инсталляторе отметить workload **«Разработка классических приложений на C++»**.
Для Web ничего дополнительно не требуется (Flutter web встроен).

## 8. Эмулятор или реальное устройство

- **Эмулятор:** Android Studio → *Device Manager* → *Create Device* (Pixel 7, образ API 34/35 с Google Play).
- **Реальное устройство (рекомендуется для оверлея/будильников/фокуса):**
  Настройки → «О телефоне» → 7 раз тапнуть по «Номер сборки» → включить *Параметры разработчика* → *Отладка по USB*.
  Подключить кабелем, проверить: `flutter devices`.

> ⚠️ Оверлей поверх экрана, полноэкранные будильники, AccessibilityService и поведение под Doze
> корректно тестируются **только на реальном устройстве**.

## 9. Финальная проверка

```powershell
flutter doctor -v
```
Ожидаемо зелёные: Flutter, Android toolchain, Android Studio, VS Code (и Windows/Chrome при установке desktop/web).
Красный «Connected device» — норма, пока устройство не подключено.

## 10. Supabase

1. Создать проект на [supabase.com](https://supabase.com) (регион — ближайший). Сохранить **Project URL** и **anon key**.
2. Установить Supabase CLI:
   ```powershell
   winget install --id Supabase.CLI -e --silent
   ```
3. `supabase login`, затем в папке проекта `supabase init` и `supabase link`.
   (Для локальной БД CLI нужен Docker Desktop — опционально; на старте можно работать с облачным проектом.)

> 🔐 Ключи Supabase **не хранить в коде и не коммитить**. Передавать через `--dart-define`:
> ```powershell
> flutter run --dart-define=SUPABASE_URL=<url> --dart-define=SUPABASE_ANON_KEY=<key>
> ```
> Удобнее задать их в `.vscode/launch.json` (файл в `.gitignore`).

## 11. Создание проекта Flutter

В пустой папке проекта:
```powershell
flutter create --org com.tasfoster --platforms=android,web,windows .
flutter run
```
