import 'package:flutter/material.dart';

class AppTheme {
  // ── Agro Green Palette ───────────────────────────────────────────────────
  static const Color primaryGreen     = Color(0xFF4CAF82); // pastel agro green
  static const Color deepGreen        = Color(0xFF2E7D55); // deep forest green
  static const Color lightGreen       = Color(0xFF80C9A0); // soft mint green
  static const Color accentLime       = Color(0xFFA8E063); // lime accent
  static const Color accentGold       = Color(0xFFFFD166); // harvest gold

  // Dark Cards — all green-family dark tones
  static const Color darkCard1        = Color(0xFF0D2B1E); // deep forest
  static const Color darkCard2        = Color(0xFF0A2414); // dark jungle
  static const Color darkCard3        = Color(0xFF132D1A); // pine dark
  static const Color darkCard4        = Color(0xFF1A3320); // fern dark
  static const Color darkCard5        = Color(0xFF0F2918); // deep moss
  static const Color darkCard6        = Color(0xFF163B25); // dark emerald

  // Scaffold & surface
  static const Color scaffoldBg       = Color(0xFFF0FAF4); // very light mint
  static const Color surfaceCard      = Color(0xFFE8F5EE); // pale green surface

  // AppBar gradient — lush agro green
  static const Color appBarGradStart  = Color(0xFF43A873);
  static const Color appBarGradEnd    = Color(0xFF256D47);

  static const Color textLight        = Colors.white;
  static const Color textDark         = Color(0xFF0D2B1E);
  static const Color textMuted        = Color(0xFF4A7A5E);

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.light,
      primary: primaryGreen,
      secondary: accentLime,
    ),
    scaffoldBackgroundColor: scaffoldBg,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: textLight,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
      iconTheme: IconThemeData(color: textLight),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28, fontWeight: FontWeight.w800, color: textDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w700, color: textDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, color: textDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: textMuted,
      ),
    ),
  );
}