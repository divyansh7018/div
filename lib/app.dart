import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state_provider.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

class LuckyFitApp extends StatelessWidget {
  const LuckyFitApp({required this.appStateProvider, super.key});
  final AppStateProvider appStateProvider;
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
    value: appStateProvider,
    child: MaterialApp(title: 'LuckyFit 90', debugShowCheckedModeBanner: false, theme: AppTheme.dark(), darkTheme: AppTheme.dark(), themeMode: ThemeMode.dark, home: const SplashScreen()),
  );
}
