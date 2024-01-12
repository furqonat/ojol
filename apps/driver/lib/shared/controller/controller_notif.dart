import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../route/route_name.dart';
import '../local_notif.dart';

class ControllerNotification extends GetxController{
  @override
  void onInit() async {
    super.onInit();
    initNotificationHandler();
  }

  initNotificationHandler() async {
    await FirebaseMessaging.instance.requestPermission();

    var token = await FirebaseMessaging.instance.getToken();
    log('token = $token');

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      log("instance");
    });

    // only work in foreground
    FirebaseMessaging.onMessage.listen((message) {
      log("onMessage");
      LocalNotificationService.displayNotification(message);
    });

    // when the app is in backgroudn but opened
    // User tap notification in tray
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log("onMessageOpenedApp");
      try {

        if(message == null) return;
        Get.toNamed(Routes.bottom_nav);

      } catch (e) {
        log("error $e");
      }
    });
  }

}