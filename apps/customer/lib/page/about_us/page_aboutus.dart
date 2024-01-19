import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/about_us/controller_aboutus.dart';

class PageAboutUs extends GetView<ControllerAboutUs> {
  const PageAboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image(
              width: Get.width,
              height: Get.height,
              fit: BoxFit.cover,
              image: const AssetImage('assets/images/lumajang.png')),
          Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87])),
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Lugo\nAbout Us',
                  style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "We are a local startup located at Lumajang, Indonesia with mission to help people move around and make people be more productive",
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Semeru Mountain, Lumajang. Indonesia",
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(Get.width, Get.height * 0.055),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: const Color(0xFF3978EF)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Kembali / Back",
                        style: GoogleFonts.readexPro(
                            fontSize: 12, color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
