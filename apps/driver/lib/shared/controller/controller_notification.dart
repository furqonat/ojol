import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:rest_client/account_client.dart';

import '../../route/route_name.dart';
import '../local_notif.dart';

class ControllerNotification extends GetxController {
  final AccountClient accountClient;

  ControllerNotification({required this.accountClient});

  final _currentUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() async {
    super.onInit();
    initNotificationHandler();
  }

  initNotificationHandler() async {
    await FirebaseMessaging.instance.requestPermission();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (_currentUser != null) {
      final resp = await _saveDeviceToken(fcmToken!);
      log(resp);
    }
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      log("instance");
    });

    FirebaseMessaging.onMessage.listen((message) {
      log("onMessage");
      LocalNotificationService.displayNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("onMessageOpenedApp");
      try {
        Get.toNamed(Routes.main);
      } catch (e) {
        log("error $e");
      }
    });
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      _saveDeviceToken(event).then((value) => log(value));
    });
  }

  Future<String> _saveDeviceToken(String fcmToken) async {
    final token = await _currentUser?.getIdToken();
    final resp = await accountClient.driverAssignDeviceToken(
      bearerToken: "Bearer $token",
      body: DeviceToken(
        token: fcmToken,
      ),
    );
    return resp.message;
  }
}
