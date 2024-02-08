import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lugo_driver/route/route_name.dart';
import 'package:lugo_driver/shared/utils.dart';
import 'controller_history_order.dart';

class PageHistoryOrder extends GetView<ControllerHistoryOrder> {
  const PageHistoryOrder({super.key});

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
          'Hari Ini',
          style:
              GoogleFonts.readexPro(fontSize: 22, fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
            onPressed: () => controller.searchByDate(context),
            icon: const Icon(Icons.date_range_rounded),
          )
        ],
      ),
      body: Obx(() {
        if (controller.loading.value == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.loading.value == Status.success) {
          return Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Text("Pendapatan hari ini"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.wallet);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height * 0.1,
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                        child: Text(
                          '${convertToIdr(10000, 0)}',
                          style: GoogleFonts.readexPro(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: controller.ordersByDate.isEmpty
                    ? ListView.builder(
                  itemCount: controller.order.length,
                  itemBuilder: (context, index) => Padding(
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
                              padding: const EdgeInsets.fromLTRB(
                                  20, 20, 20, 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  controller.order[index].orderType ==
                                      'CAR'
                                      ? const Icon(CupertinoIcons.car,
                                      color: Color(0xFF3978EF))
                                      : controller.order[index]
                                      .orderType ==
                                      'BIKE'
                                      ? const Icon(
                                      Icons.directions_bike,
                                      color: Color(0xFF3978EF))
                                      : controller.order[index]
                                      .orderType ==
                                      'FOOD'
                                      ? const Icon(
                                      Icons.fastfood_rounded,
                                      color:
                                      Color(0xFF3978EF))
                                      : controller.order[index]
                                      .orderType ==
                                      'MART'
                                      ? const Icon(Icons.shopping_bag_rounded,
                                      color: Color(
                                          0xFF3978EF))
                                      : controller
                                      .order[
                                  index]
                                      .orderType ==
                                      'DELIVERY'
                                      ? const Icon(
                                      CupertinoIcons.gift,
                                      color: Color(0xFF3978EF))
                                      : const SizedBox(),
                                  Text(
                                    DateFormat("dd MMMM yyyy").format(
                                        controller
                                            .order[index].createdAt!),
                                    style: GoogleFonts.readexPro(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(20),
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Pemesan',
                                    style: GoogleFonts.readexPro(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    '${controller.order[index].customer?.name}',
                                    style: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Nomor Transaksi',
                                    style: GoogleFonts.readexPro(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.5,
                                    child: Text(
                                      '${controller.order[index].id}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.readexPro(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20, 0, 20, 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Total Bayar',
                                    style: GoogleFonts.readexPro(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    convertToIdr(
                                        controller
                                            .order[index].totalAmount,
                                        0),
                                    style: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: controller.ordersByDate.length,
                  itemBuilder: (context, index) => Padding(
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
                              padding: const EdgeInsets.fromLTRB(
                                  20, 20, 20, 0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  controller.ordersByDate[index]
                                      .orderType ==
                                      'CAR'
                                      ? const Icon(CupertinoIcons.car,
                                      color: Color(0xFF3978EF))
                                      : controller.ordersByDate[index]
                                      .orderType ==
                                      'BIKE'
                                      ? const Icon(
                                      Icons.directions_bike,
                                      color: Color(0xFF3978EF))
                                      : controller.ordersByDate[index]
                                      .orderType ==
                                      'FOOD'
                                      ? const Icon(
                                      Icons.fastfood_rounded,
                                      color:
                                      Color(0xFF3978EF))
                                      : controller.ordersByDate[index].orderType ==
                                      'MART'
                                      ? const Icon(Icons.shopping_bag_rounded,
                                      color: Color(
                                          0xFF3978EF))
                                      : controller
                                      .ordersByDate[
                                  index]
                                      .orderType ==
                                      'DELIVERY'
                                      ? const Icon(
                                      CupertinoIcons.gift,
                                      color: Color(0xFF3978EF))
                                      : const SizedBox(),
                                  Text(
                                    DateFormat("dd MMMM yyyy").format(
                                        controller.ordersByDate[index]
                                            .createdAt!),
                                    style: GoogleFonts.readexPro(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(20),
                              child: Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Pemesan',
                                    style: GoogleFonts.readexPro(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    '${controller.ordersByDate[index].customer?.name}',
                                    style: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Nomor Transaksi',
                                    style: GoogleFonts.readexPro(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.5,
                                    child: Text(
                                      '${controller.ordersByDate[index].id}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.readexPro(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20, 0, 20, 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Total Bayar',
                                    style: GoogleFonts.readexPro(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    convertToIdr(
                                        controller.ordersByDate[index]
                                            .totalAmount,
                                        0),
                                    style: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        } else if (controller.order.isEmpty) {
          return Center(
            child: Text(
              "Anda belum pernah mendapat pesanan",
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          );
        } else {
          return Center(
            child: Text(
              "Ada yang salah",
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          );
        }
      }),
    );
  }
}
