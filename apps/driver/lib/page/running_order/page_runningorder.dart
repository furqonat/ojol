import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lugo_driver/shared/custom_widget/lugo_button.dart';
import '../../shared/utils.dart';
import 'controller_runningorder.dart';

class PageRunningOrder extends GetView<ControllerRunningOrder> {
  const PageRunningOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Pesanan Berjalan',
          style: GoogleFonts.readexPro(
              fontSize: 22, fontWeight: FontWeight.w400),
        ),
      ),
      body: Obx(() {
        if (controller.loading.value == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.loading.value == Status.success) {
          return ListView.builder(
            itemCount: controller.freeOrder.length,
            itemBuilder: (context, index) => Visibility(
              visible: controller.freeOrder[index].showable!,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: SizedBox(
                  width: Get.width,
                  child: Card(
                    elevation: 5,
                    surfaceTintColor: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.freeOrder[index].orderType}",
                                style: GoogleFonts.readexPro(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF3978EF),
                                ),
                              ),
                              Text(
                                DateFormat('dd/MM/yyyy - HH:mm').format(
                                    controller.freeOrder[index].createdAt!),
                                style: GoogleFonts.readexPro(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jenis Pembayaran",
                                style: GoogleFonts.readexPro(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              Text(
                                controller.freeOrder[index].paymentType!,
                                style: GoogleFonts.readexPro(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Pembayaran",
                                style: GoogleFonts.readexPro(
                                    color: Colors.grey, fontSize: 12),
                              ),
                              Text(
                                convertToIdr(
                                    controller.freeOrder[index].totalAmount, 0),
                                style: GoogleFonts.readexPro(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.location_solid,
                                color: Color(0xFF3978EF),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.width * 0.7,
                                child: Text(
                                  controller.freeOrder[index].orderDetail
                                      ?.address ??
                                      '-',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.readexPro(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            children: [
                              const Icon(CupertinoIcons.location_solid,
                                  color: Colors.orangeAccent),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: Get.width * 0.7,
                                child: Text(
                                  controller.freeOrder[index].orderDetail
                                      ?.dstAddress ??
                                      '',
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.readexPro(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: LugoButton(
                                textButton: 'Terima',
                                textColor: Colors.white,
                                textSize: 12,
                                width: Get.width,
                                height: Get.height * 0.05,
                                color: const Color(0xFF3978EF),
                                onTap: () => controller.orderAccept(controller.freeOrder[index].id!, index)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (controller.freeOrder.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    onPressed: () => controller.getListOrder(),
                    icon: const Icon(CupertinoIcons.refresh_circled_solid,
                        size: 100, color: Color(0xFF3978EF))),
                Text(
                  "Tidak ada pesanan untuk sekarang\nCoba lagi.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.readexPro(fontSize: 16),
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: Text("Ada yang salah"),
          );
        }
      }),
    );
  }
}
