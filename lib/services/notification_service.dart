import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await plugin.initialize(const InitializationSettings(android: android, iOS: ios));
  }
  Future<void> showDailyMotivation() => plugin.show(1, 'LuckyFit 90', 'Your 90-day transformation starts with today.', const NotificationDetails(android: AndroidNotificationDetails('motivation', 'Daily Motivation', importance: Importance.defaultImportance)));
}
