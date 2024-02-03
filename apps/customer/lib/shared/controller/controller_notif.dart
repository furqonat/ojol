import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/api/local_service.dart';
import '../local_notif.dart';

class ControllerNotification extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    subscribeFmcTopic();
    initNotificationHandler();
  }

  subscribeFmcTopic() async {
    log("did i run");
    await FirebaseMessaging.instance.subscribeToTopic("MERCHANT");
  }

  initNotificationHandler() async {
    await FirebaseMessaging.instance.requestPermission();

    var token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await LocalService().setTokenDevice(tokenDevice: token);
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
      await LocalService().setTokenDevice(tokenDevice: event);
    });

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
