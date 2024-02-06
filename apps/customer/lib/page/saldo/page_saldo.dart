import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/saldo/controller_saldo.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:lugo_customer/shared/utils.dart';

class PageSaldo extends GetView<ControllerSaldo> {
  const PageSaldo({super.key});

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
            onTap: () => Get.offNamed(Routes.home),
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
        actions: [
          const Image(
              width: 80.0,
              height: 30.0,
              fit: BoxFit.contain,
              image: AssetImage("assets/images/1699744330264.png")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Obx(() => controller.loading.value == Status.loading
                ? Text(
              "+62...",
              style: GoogleFonts.readexPro(
                  fontSize: 16,
                  color: const Color(0xFF14181B),
                  fontWeight: FontWeight.w600),
            )
                : Text(
              "${controller.firebase.currentUser?.phoneNumber}",
              style: GoogleFonts.readexPro(
                  fontSize: 16,
                  color: const Color(0xFF14181B),
                  fontWeight: FontWeight.w600),
            )),
          )
        ],
      ),
      body: Obx(() {
        if (controller.loading.value == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3978EF),
            ),
          );
        } else if (controller.loading.value == Status.success) {
          return Container(
            width: Get.width,
            height: Get.height * 0.2,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3978EF),
                      Colors.lightBlue
                    ])
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Text(
                      "Saldo tersedia",
                      style: GoogleFonts.readexPro(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    convertToIdr(double.parse(controller.saldo.value.value!), 0),
                    style: GoogleFonts.readexPro(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Text(
              'Ada yang salah',
              style: GoogleFonts.readexPro(fontSize: 12),
            ),
          );
        }
      }),
    );
  }
}
