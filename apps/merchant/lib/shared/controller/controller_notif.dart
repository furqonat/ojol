import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:rest_client/account_client.dart';
import '../local_notif.dart';

class ControllerNotification extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    initToken();
    refreshToken();
    initNotificationHandler();
  }

  initToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    handleSendApplyToken(fcmToken!);
  }

  refreshToken() {
    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      handleSendApplyToken(event);
    });
  }

  handleSendApplyToken(String fcmToken) async {
    final dio = Dio();
    final client = AccountClient(dio);
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    final resp = await client.merchantAssignDeviceToken(
      bearerToken: "Bearer $token",
      body: DeviceToken(token: fcmToken),
    );
    print(resp.message);
  }

  initNotificationHandler() async {
    await FirebaseMessaging.instance.requestPermission();

    final token = await FirebaseMessaging.instance.getToken();
    log('token = $token');

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      log("instance");
    });

    FirebaseMessaging.onMessage.listen((message) {
      log("onMessage");
      LocalNotificationService.displayNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("onMessageOpenedApp");
      try {} catch (e) {
        log("error $e");
      }
    });
  }
}
