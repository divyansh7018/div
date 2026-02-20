import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/chat_provider.dart';
import 'providers/journal_provider.dart';
import 'providers/mood_provider.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/auth/auth_gate.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'services/ai_service.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'services/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Firebase config may be missing in local/test environments.
  }

  final localStorageService = LocalStorageService();
  final moodProvider = MoodProvider(localStorageService);
  final taskProvider = TaskProvider(localStorageService);
  final journalProvider = JournalProvider(localStorageService);

  await Future.wait([moodProvider.init(), taskProvider.init(), journalProvider.init()]);

  runApp(
    MindMitraApp(
      moodProvider: moodProvider,
      taskProvider: taskProvider,
      journalProvider: journalProvider,
      chatProvider: ChatProvider(AIService()),
      authProvider: AuthProvider(AuthService(), FirestoreService()),
    ),
  );
}

class MindMitraApp extends StatelessWidget {
  const MindMitraApp({
    required this.moodProvider,
    required this.taskProvider,
    required this.journalProvider,
    required this.chatProvider,
    required this.authProvider,
    super.key,
  });

  final MoodProvider moodProvider;
  final TaskProvider taskProvider;
  final JournalProvider journalProvider;
  final ChatProvider chatProvider;
  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: authProvider),
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
            home: const OnboardingOrAuthGate(),
          );
        },
      ),
    );
  }
}

class OnboardingOrAuthGate extends StatefulWidget {
  const OnboardingOrAuthGate({super.key});

  @override
  State<OnboardingOrAuthGate> createState() => _OnboardingOrAuthGateState();
}

class _OnboardingOrAuthGateState extends State<OnboardingOrAuthGate> {
  bool _showOnboarding = true;

  @override
  Widget build(BuildContext context) {
    if (_showOnboarding) {
      return OnboardingScreen(onDone: () => setState(() => _showOnboarding = false));
    }
    return const AuthGate();
  }
}
