import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/splash_screen/controller_splash.dart';

class PageSplash extends GetView<ControllerSplash> {
  const PageSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
