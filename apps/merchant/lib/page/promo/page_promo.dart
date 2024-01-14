import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/promo/controller_promo.dart';

class PagePromo extends GetView<ControllerPromo> {
  const PagePromo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Expanded(
          child: ListView.builder(
        itemCount: 10,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {},
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
                      image:
                          const AssetImage('assets/images/sample_point.jpg')),
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
                    "Gratis ongkir berlaku sejak 22/08 - 22/09/2023",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.readexPro(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
