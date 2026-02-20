import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static const _radius = BorderRadius.all(Radius.circular(20));

  static ThemeData lightTheme() {
    const colorScheme = ColorScheme.light(
      primary: Color(0xFF8B8EF9),
      secondary: Color(0xFF7CC9F5),
      tertiary: Color(0xFF9EEBCF),
      surface: Color(0xFFF5F7FF),
      onSurface: Color(0xFF23243A),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFFF3F5FF),
      cardTheme: const CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: _radius),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.white.withOpacity(0.85),
      ),
    );
  }

  static ThemeData darkTheme() {
    const colorScheme = ColorScheme.dark(
      primary: Color(0xFFADB0FF),
      secondary: Color(0xFF8FD7FF),
      tertiary: Color(0xFFA8F3DB),
      surface: Color(0xFF1E2238),
      onSurface: Color(0xFFF4F5FF),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFF111426),
      cardTheme: const CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: _radius),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.white.withOpacity(0.08),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  const GlassCard({required this.child, super.key, this.padding = const EdgeInsets.all(16)});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: isDark ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.55),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: child,
        ),
      ),
    );
  }
}
