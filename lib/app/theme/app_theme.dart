import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Тема оформления в RPG/фэнтези-стиле.
/// Базовые цвета: глубокий пурпур (магия) + золото (награды/валюта).
class AppTheme {
  AppTheme._();

  /// Фирменные цвета.
  static const Color arcanePurple = Color(0xFF6D28D9); // мана/магия
  static const Color guildGold = Color(0xFFD4AF37); // золото/награды
  static const Color emberOrange = Color(0xFFEA580C); // стрики/огонь
  static const Color forestGreen = Color(0xFF16A34A); // здоровье/природа
  static const Color crystalBlue = Color(0xFF38BDF8); // кристаллы/премиум

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: arcanePurple,
      brightness: brightness,
      primary: arcanePurple,
      secondary: guildGold,
      tertiary: crystalBlue,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
    );

    // Заголовки — «фэнтезийным» шрифтом Cinzel, текст — читаемым Inter.
    final textTheme = GoogleFonts.interTextTheme(base.textTheme).copyWith(
      displayLarge: GoogleFonts.cinzel(textStyle: base.textTheme.displayLarge, fontWeight: FontWeight.w700),
      displayMedium: GoogleFonts.cinzel(textStyle: base.textTheme.displayMedium, fontWeight: FontWeight.w700),
      headlineLarge: GoogleFonts.cinzel(textStyle: base.textTheme.headlineLarge, fontWeight: FontWeight.w600),
      headlineMedium: GoogleFonts.cinzel(textStyle: base.textTheme.headlineMedium, fontWeight: FontWeight.w600),
      titleLarge: GoogleFonts.cinzel(textStyle: base.textTheme.titleLarge, fontWeight: FontWeight.w600),
    );

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        titleTextStyle: GoogleFonts.cinzel(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: scheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainer,
        indicatorColor: scheme.primary.withValues(alpha: 0.18),
        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
