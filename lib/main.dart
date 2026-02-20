import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

const _onboardingSeenKey = 'onboarding_seen';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase init skipped: $e');
  }

  final localStorageService = LocalStorageService();
  final moodProvider = MoodProvider(localStorageService);
  final taskProvider = TaskProvider(localStorageService);
  final journalProvider = JournalProvider(localStorageService);

  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool(_onboardingSeenKey) ?? false;

  await Future.wait([moodProvider.init(), taskProvider.init(), journalProvider.init()]);

  runApp(
    MindMitraApp(
      moodProvider: moodProvider,
      taskProvider: taskProvider,
      journalProvider: journalProvider,
      chatProvider: ChatProvider(AIService()),
      authProvider: AuthProvider(AuthService(), FirestoreService()),
      hasSeenOnboarding: hasSeenOnboarding,
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
    required this.hasSeenOnboarding,
    super.key,
  });

  final MoodProvider moodProvider;
  final TaskProvider taskProvider;
  final JournalProvider journalProvider;
  final ChatProvider chatProvider;
  final AuthProvider authProvider;
  final bool hasSeenOnboarding;

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
            home: OnboardingOrAuthGate(hasSeenOnboarding: hasSeenOnboarding),
          );
        },
      ),
    );
  }
}

class OnboardingOrAuthGate extends StatefulWidget {
  const OnboardingOrAuthGate({required this.hasSeenOnboarding, super.key});

  final bool hasSeenOnboarding;

  @override
  State<OnboardingOrAuthGate> createState() => _OnboardingOrAuthGateState();
}

class _OnboardingOrAuthGateState extends State<OnboardingOrAuthGate> {
  late bool _showOnboarding;

  @override
  void initState() {
    super.initState();
    _showOnboarding = !widget.hasSeenOnboarding;
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingSeenKey, true);
    if (!mounted) return;
    setState(() => _showOnboarding = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_showOnboarding) {
      return OnboardingScreen(onDone: _completeOnboarding);
    }
    return const AuthGate();
  }
}
