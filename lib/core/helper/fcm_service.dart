import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final fcmServiceProvider = Provider<FCMService>((ref) {
  return FCMService();
});
final fcmTokenProvider = StateProvider<String?>((ref) => null);
final fcmNotificationProvider = StateProvider<RemoteMessage?>((ref) => null);
final fcmInitializeProvider = FutureProvider<void>((ref) async {
  final fcmService = ref.read(fcmServiceProvider);
  await fcmService.initialize();
  // Update token provider when initialized
  final token = fcmService.fcmToken;
  if (token != null) {
    ref.read(fcmTokenProvider.notifier).state = token;
  }
});

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? _fcmToken;
  String? get fcmToken => _fcmToken;
  ProviderContainer? _container;

  void setProviderContainer(ProviderContainer container) {
    _container = container;
  }

  Future<void> initialize() async {
    await _requestPermissions();
    await _initializeLocalNotifications();
    await _getToken();
    await _setupMessageHandlers();
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
    } else {
      await Permission.notification.request();
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosSettings,
        );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
    if (Platform.isAndroid) {
      await _createNotificationChannel();
    }
  }

  Future<void> _getToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      if (kDebugMode) {
        print('FCM Token: $_fcmToken');
      }
      // Update Riverpod provider
      _container?.read(fcmTokenProvider.notifier).state = _fcmToken;
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        _container?.read(fcmTokenProvider.notifier).state = newToken;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error getting FCM token: $e');
      }
    }
  }

  Future<void> _setupMessageHandlers() async {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
          'high_importance_channel',
          'High Importance Notifications',
          description: 'This channel is used for important notifications.',
          importance: Importance.high,
        );
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    if (kDebugMode) {
      print('Foreground message: ${message.messageId}');
      print('Data: ${message.data}');
    }
    _container?.read(fcmNotificationProvider.notifier).state = message;
    await _showLocalNotification(message);
  }

  //Future<void> _handleBackgroundMessage(RemoteMessage message) async {}
  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      final Map<String, dynamic> data = jsonDecode(response.payload!);
      _handleNotificationNavigation(data);
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    if (kDebugMode) {
      print('Notification tapped: ${message.messageId}');
      print('Data: ${message.data}');
    }

    // Update Riverpod provider
    _container?.read(fcmNotificationProvider.notifier).state = message;

    _handleNotificationNavigation(message.data);
  }

  void _handleNotificationNavigation(Map<String, dynamic> data) {
    if (kDebugMode) {
      print('Handling notification navigation with data: $data');
    }
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.high,
          priority: Priority.high,
          showWhen: true,
        );
    // const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
    //   presentAlert: true,
    //   presentBadge: true,
    //   presentSound: true,
    // );
    const NotificationDetails details = NotificationDetails(
      android: androidNotificationDetails,
      //iOS: iosDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
      message.hashCode,
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? 'You have a new message',
      details,
      payload: jsonEncode(message.data),
    );
  }

  //  Future<void> subscribeToTopic(String topic) async {
  //   try {
  //     await _firebaseMessaging.subscribeToTopic(topic);
  //     if (kDebugMode) {
  //       print('Subscribed to topic: $topic');
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error subscribing to topic: $e');
  //     }
  //   }
  // }

  // Future<void> unsubscribeFromTopic(String topic) async {
  //   try {
  //     await _firebaseMessaging.unsubscribeFromTopic(topic);
  //     if (kDebugMode) {
  //       print('Unsubscribed from topic: $topic');
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print('Error unsubscribing from topic: $e');
  //     }
  //   }
  // }
}

@pragma('vm:entry-point')
Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print('Background message: ${message.messageId}');
    print('Data: ${message.data}');
  }
}
