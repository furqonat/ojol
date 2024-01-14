import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_marchant/page/splash_screen/controller_splash.dart';

class PageSplash extends GetView<ControllerSplash> {
  const PageSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image(
                    width: Get.width * 0.7,
                    alignment: Alignment.center,
                    image: const AssetImage('assets/images/logo_merchant.png')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
