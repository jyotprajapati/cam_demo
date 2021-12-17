import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channel_id = "123";

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, macOS: null);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void showNotification({String? title, String? notificationMessage}) async {
    await flutterLocalNotificationsPlugin.show(
      123,
      title,
      notificationMessage,
      const NotificationDetails(
          android: AndroidNotificationDetails(
        channel_id,
        "Alemeno",
      )),
    );
  }
}
