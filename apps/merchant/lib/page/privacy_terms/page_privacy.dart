import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/privacy_terms/controller_privacy.dart';

class PagePrivacy extends GetView<ControllerPrivacy>{
  const PagePrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Image(
                width: Get.width,
                height: Get.height,
                fit: BoxFit.cover,
                image: const AssetImage('assets/images/lumajang.png')
            ),
            Container(
              width: Get.width,
              height: Get.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black87
                      ]
                  )
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Lugo\nPrivacy Terms',
                    style: GoogleFonts.poppins(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "In order to run our services, our privacy terms would require us to have several access. Such as",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.mic_none_rounded, color: Colors.white),
                        Text(
                          "Mic access",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w300
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.camera_alt_outlined, color: Colors.white),
                        Text(
                          "Camera access",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w300
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.not_listed_location_outlined, color: Colors.white),
                        Text(
                          "Location Access",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w300
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.folder_copy_rounded, color: Colors.white,),
                      Text(
                        "Gallery Access",
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w300
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Obx(() => Checkbox(
                          side: const BorderSide(
                              color: Colors.white,
                              width: 1
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                          activeColor: const Color(0xFF3978EF),
                          value: controller.termsAggreent.value,
                          onChanged: (value) => controller.termsAggreent(value),
                        )),
                        Text(
                          "Saya setuju dengan syarat & Ketentuan",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w300
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ElevatedButton(
                        onPressed: ()=> Get.back(),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: Size(Get.width, Get.height * 0.055),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            backgroundColor: const Color(0xFF3978EF)
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Kembali / Back",
                            style: GoogleFonts.readexPro(
                                fontSize: 12,
                                color: Colors.white
                            ),
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}