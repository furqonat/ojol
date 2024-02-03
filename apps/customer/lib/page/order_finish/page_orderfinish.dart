import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/api/local_service.dart';
import 'package:lugo_customer/page/order_finish/controller_orderfinish.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:lugo_customer/shared/utils.dart';

class PageOrderFinish extends GetView<ControllerOrderFinish> {
  const PageOrderFinish({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text("Sudah Sampai",
            style: GoogleFonts.readexPro(
              color: const Color(0xFF3978EF),
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Obx(() {
        if(controller.loading.value == Status.loading){
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF3978EF)),
          );
        }else if (controller.loading.value == Status.success){
          return Column(
            children: <Widget>[
              Container(
                width: Get.width,
                height: Get.height * 0.2,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(5, 5),
                      blurRadius: 10
                    )
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                        "Pesanan Selesai",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                        "Handle by:",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${controller.driver.value.name}',
                      style: GoogleFonts.readexPro(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${controller.driver.value.driverDetails?.vehicle?.vehicleRn}',
                      style: GoogleFonts.readexPro(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${controller.driver.value.driverDetails?.vehicle?.vehicleBrand}',
                      style: GoogleFonts.readexPro(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: RichText(
                    text: TextSpan(
                        style: GoogleFonts.readexPro(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3978EF)),
                        children: <TextSpan>[
                          const TextSpan(text: 'ID Transaksi'),
                          TextSpan(
                              text: ' ${controller.transId.value}',
                              style: GoogleFonts.readexPro(
                                  fontSize: 16, color: Colors.black54)),
                        ])),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: RichText(
                    text: TextSpan(
                        style: GoogleFonts.readexPro(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3978EF)),
                        children: <TextSpan>[
                          const TextSpan(text: 'ID Order'),
                          TextSpan(
                              text: ' ${controller.orderId.value}',
                              style: GoogleFonts.readexPro(
                                  fontSize: 16, color: Colors.black54)),
                        ])),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: RichText(
                    text: TextSpan(
                        style: GoogleFonts.readexPro(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3978EF)),
                        children: <TextSpan>[
                          const TextSpan(text: 'Pembayaran'),
                          TextSpan(
                              text: ' | ${controller.payType.value}',
                              style: GoogleFonts.readexPro(
                                  fontSize: 16, color: Colors.black54)),
                        ])),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
                child: Text(
                  convertToIdr(controller.price.value, 0),
                  style: GoogleFonts.readexPro(
                    fontSize: 30,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                    onPressed: () async {
                      await LocalService().orderFinish();
                      Get.offAllNamed(Routes.home);
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        fixedSize: Size(Get.width, Get.height * 0.06),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: const Color(0xFF3978EF)),
                    child: Text(
                      "Selesai",
                      style: GoogleFonts.readexPro(
                          fontSize: 16, color: Colors.white),
                    )),
              )
            ],
          );
        }else{
          return Center(
            child: Text(
              "Ada yang salah",
              style: GoogleFonts.readexPro(
                fontSize: 14
              ),
            ),
          );
        }
      }
      ),
    );
  }
}
