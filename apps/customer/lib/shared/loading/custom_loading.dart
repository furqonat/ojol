import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

CustomLoading(){
  return SizedBox(
    width: Get.width,
    height: Get.height,
    child: Column(
      children: <Widget>[
        SafeArea(
            child: Text(
                "Sedang Mencari Driver",
                style: GoogleFonts.readexPro(
                  fontSize: 30.0,
                  color: const Color(0xFF3978EF),
                  fontWeight: FontWeight.bold,
                )
            )
        ),
        const Spacer(),
        const Image(
            height: 300,
            width: 300,
            fit: BoxFit.contain,
            image: AssetImage('assets/images/2023-05-05_(4).png')
        ).animate().rotate(duration: const Duration(seconds: 3)),
        const Spacer(flex: 2),
      ],
    ),
  );
}