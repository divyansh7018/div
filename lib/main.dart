import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'providers/chat_provider.dart';
import 'providers/journal_provider.dart';
import 'providers/mood_provider.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'services/ai_service.dart';
import 'services/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localStorageService = LocalStorageService();
  final moodProvider = MoodProvider(localStorageService);
  final taskProvider = TaskProvider(localStorageService);
  final journalProvider = JournalProvider(localStorageService);

  await Future.wait([moodProvider.init(), taskProvider.init(), journalProvider.init()]);

  runApp(MindMitraApp(
    moodProvider: moodProvider,
    taskProvider: taskProvider,
    journalProvider: journalProvider,
    chatProvider: ChatProvider(AIService()),
  ));
}

class MindMitraApp extends StatelessWidget {
  const MindMitraApp({
    required this.moodProvider,
    required this.taskProvider,
    required this.journalProvider,
    required this.chatProvider,
    super.key,
  });

  final MoodProvider moodProvider;
  final TaskProvider taskProvider;
  final JournalProvider journalProvider;
  final ChatProvider chatProvider;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: moodProvider),
        ChangeNotifierProvider.value(value: taskProvider),
        ChangeNotifierProvider.value(value: journalProvider),
        ChangeNotifierProvider.value(value: chatProvider),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'MindMitra',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: themeProvider.themeMode,
            home: const OnboardingScreen(),
          );
        },
      ),
    );
  }
}
