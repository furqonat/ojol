import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:lugo_customer/page/discount/controller_discount.dart';
import 'package:lugo_customer/shared/utils.dart';

class PageDiscount extends GetView<ControllerDiscount> {
  const PageDiscount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.loading.value == Status.loading) {
          return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3978EF)));
        } else if (controller.discount.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/no_discount.json'),
                Text(
                  "Yahh tidak ada token yang bisa dipakai",
                  style: GoogleFonts.readexPro(fontSize: 14),
                )
              ],
            ),
          );
        } else if (controller.loading.value == Status.failed) {
          return Center(
            child: Text(
              "Ada yang salah",
              style: GoogleFonts.openSans(
                fontSize: 20,
              ),
            ),
          );
        } else if (controller.loading.value == Status.success) {
          return SizedBox(
            width: Get.width,
            height: Get.height,
            child: ListView.builder(
              itemCount: controller.discount.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Clipboard.setData(
                        ClipboardData(text: controller.discount[index].id!))
                    .then((value) => Fluttertoast.showToast(
                        msg: "Kode sudah ada copy pada clipboard")),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: SizedBox(
                    width: Get.width,
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      surfaceTintColor: const Color(0xFF3978EF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Text("RIDER5K",
                                style: GoogleFonts.readexPro(fontSize: 14)),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                            child: Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Text(
                              "Gunakan dan dapatkan keuntungan sebanyak ${convertToIdr(5000, 0)}",
                              style: GoogleFonts.readexPro(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Mininal transaksi ${convertToIdr(controller.discount[index].minTransaction, 0)}\nBerlaku hingga ${DateFormat('dd/MM/yyyy').format(DateTime.now())}",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.readexPro(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Text(
              "Ada yang salah",
              style: GoogleFonts.openSans(
                fontSize: 20,
              ),
            ),
          );
        }
      }),
    );
  }
}
