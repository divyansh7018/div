import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

class AppTheme {
  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppConstants.background,
      colorScheme: const ColorScheme.dark(
        primary: AppConstants.gold,
        secondary: AppConstants.accent,
        surface: AppConstants.card,
        background: AppConstants.background,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).apply(bodyColor: Colors.white, displayColor: Colors.white),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0, centerTitle: false),
      cardTheme: CardTheme(color: AppConstants.card, elevation: 10, shadowColor: Colors.black54, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radius))),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(backgroundColor: AppConstants.gold, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)), padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: AppConstants.card, selectedItemColor: AppConstants.gold, unselectedItemColor: Colors.white54, type: BottomNavigationBarType.fixed),
      checkboxTheme: CheckboxThemeData(fillColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.selected) ? AppConstants.gold : Colors.transparent)),
    );
  }
}
