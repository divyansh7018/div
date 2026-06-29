import 'package:flutter/material.dart';
import 'app.dart';
import 'providers/app_state_provider.dart';
import 'services/local_storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = LocalStorageService();
  await storage.init();
  final appState = AppStateProvider(storage);
  await appState.init();
  runApp(LuckyFitApp(appStateProvider: appState));
}
