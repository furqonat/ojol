import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/welcome/controller_welcome.dart';
import 'package:lugo_marchant/route/route_name.dart';
import 'package:lugo_marchant/shared/custom_widget/lugo_btn.dart';

class PageWelcome extends GetView<ControllerWelcome> {
  const PageWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Selamat datang',
          style: GoogleFonts.readexPro(
            fontSize: 30.0,
            color: const Color(0xFF3978EF),
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          height: Get.height * 0.87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Image(
                      width: Get.width * 0.5,
                      alignment: Alignment.center,
                      image:
                          const AssetImage('assets/images/logo_merchant.png')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: LugoButton(
                    textButton: 'Lanjutkan',
                    textColor: Colors.white,
                    textSize: 16,
                    width: Get.width,
                    height: Get.height * 0.06,
                    color: const Color(0xFF3978EF),
                    onTap: () => Get.toNamed(Routes.auth)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
