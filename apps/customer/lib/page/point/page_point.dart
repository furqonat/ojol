import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/point/controller_point.dart';
import 'package:lugo_customer/route/route_name.dart';

class PagePoint extends GetView<ControllerPoint> {
  const PagePoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: InkWell(
            onTap: () => Get.back(),
            child: SizedBox(
              width: 55,
              height: 55,
              child: Card(
                elevation: 0,
                color: const Color(0xFF3978EF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: const Center(
                  child:
                      Icon(Icons.chevron_left, size: 24, color: Colors.white),
                ),
              ),
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: Get.width,
            height: Get.height * 0.08,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xFF3978EF),
                borderRadius: BorderRadius.circular(12)),
            child: Text(
              "Poin | Rp 20.000",
              style: GoogleFonts.readexPro(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Tukar point kamu",
              style: GoogleFonts.readexPro(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Get.toNamed(Routes.detail_point),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                          width: Get.width,
                          height: Get.height * 0.25,
                          fit: BoxFit.cover,
                          image: const AssetImage(
                              'assets/images/sample_point.jpg')),
                    ),
                    Container(
                      width: Get.width,
                      height: Get.height * 0.25,
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              end: Alignment.centerRight,
                              begin: Alignment.centerLeft,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7)
                              ])),
                      child: Text(
                        "2000 Point",
                        style: GoogleFonts.readexPro(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
