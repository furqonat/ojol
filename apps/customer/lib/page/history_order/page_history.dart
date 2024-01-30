import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lugo_customer/page/history_order/controller_history.dart';
import 'package:lugo_customer/shared/utils.dart';

class PageHistory extends GetView<ControllerHistory> {
  const PageHistory({super.key});

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
        title: Obx(() => Text(
              DateFormat('dd MMMM yyyy').format(controller.filterDate.value),
              style: GoogleFonts.readexPro(
                  fontSize: 22, fontWeight: FontWeight.w400),
            )),
        actions: [
          SizedBox(
            width: 50,
            height: 50,
            child: InkWell(
              onTap: () async {
                controller.searchByDate(context);
              },
              child: Card(
                elevation: 0,
                color: const Color(0xFF3978EF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child:
                    const Icon(Icons.date_range_rounded, color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (controller.loading.value == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF3978EF)),
          );
        } else if (controller.loading.value == Status.success) {
          return controller.ordersByDate.isEmpty
              ? ListView.builder(
                  itemCount: controller.orders.length,
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
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  controller.orders[index].orderType == 'CAR'
                                      ? const Icon(CupertinoIcons.car,
                                          color: Color(0xFF3978EF))
                                      : controller.orders[index].orderType ==
                                              'BIKE'
                                          ? const Icon(Icons.directions_bike,
                                              color: Color(0xFF3978EF))
                                          : controller.orders[index]
                                                      .orderType ==
                                                  'FOOD'
                                              ? const Icon(
                                                  Icons.fastfood_rounded,
                                                  color: Color(0xFF3978EF))
                                              : controller.orders[index]
                                                          .orderType ==
                                                      'MART'
                                                  ? const Icon(
                                                      Icons
                                                          .shopping_bag_rounded,
                                                      color: Color(0xFF3978EF))
                                                  : controller.orders[index]
                                                              .orderType ==
                                                          'DELIVERY'
                                                      ? const Icon(
                                                          CupertinoIcons.gift,
                                                          color:
                                                              Color(0xFF3978EF))
                                                      : const SizedBox(),
                                  Text(
                                    DateFormat("dd MMMM yyyy").format(
                                        controller.orders[index].createdAt!),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                    '${controller.orders[index].customer?.name}',
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
                                  Text(
                                    '${controller.orders[index].customer?.id}',
                                    style: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                        controller.orders[index].totalAmount,
                                        0),
                                    style: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 12),
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
                            Visibility(
                                visible: controller.orders[index].orderType ==
                                            "FOOD" ||
                                        controller.orders[index].orderType ==
                                            "MART"
                                    ? true
                                    : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Card(
                                    elevation: 5,
                                    surfaceTintColor: const Color(0xFF3978EF),
                                    child: CarouselSlider.builder(
                                      itemCount: controller
                                          .orders[index].orderItems?.length,
                                      options: CarouselOptions(
                                          height: 100,
                                          viewportFraction: 1,
                                          autoPlay: false),
                                      itemBuilder:
                                          (context, indexImg, realIndex) => Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: CachedNetworkImage(
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                              imageUrl: controller
                                                      .orders[index]
                                                      .orderItems![indexImg]
                                                      .product!
                                                      .image ??
                                                  '',
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Image(
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          'assets/images/sample_food.png')),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Nama pesanan",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                controller
                                                    .orders[index]
                                                    .orderItems![indexImg]
                                                    .product!
                                                    .name!,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "Harga",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                convertToIdr(
                                                    controller
                                                        .orders[index]
                                                        .orderItems![indexImg]
                                                        .product!
                                                        .price!,
                                                    0),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 10),
                                            child: Text(
                                              "${controller.orders[index].orderItems![indexImg].quantity}X",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            Visibility(
                                visible: controller.orders[index].orderType ==
                                            "BIKE" ||
                                        controller.orders[index].orderType ==
                                            "CAR" ||
                                        controller.orders[index].orderType ==
                                            "DELIVERY"
                                    ? true
                                    : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          const Icon(CupertinoIcons.placemark,
                                              color: Color(0xFF3978EF)),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: Get.width * 0.75,
                                            child: Text(
                                              "${controller.orders[index].orderDetail?.address}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.readexPro(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          const Icon(CupertinoIcons.placemark,
                                              color: Colors.deepOrange),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: Get.width * 0.75,
                                            child: Text(
                                              controller
                                                      .orders[index]
                                                      .orderDetail
                                                      ?.dstAddress ??
                                                  '-',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.readexPro(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
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
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  controller.ordersByDate[index].orderType ==
                                          'CAR'
                                      ? const Icon(CupertinoIcons.car,
                                          color: Color(0xFF3978EF))
                                      : controller.ordersByDate[index]
                                                  .orderType ==
                                              'BIKE'
                                          ? const Icon(Icons.directions_bike,
                                              color: Color(0xFF3978EF))
                                          : controller.ordersByDate[index]
                                                      .orderType ==
                                                  'FOOD'
                                              ? const Icon(
                                                  Icons.fastfood_rounded,
                                                  color: Color(0xFF3978EF))
                                              : controller.ordersByDate[index]
                                                          .orderType ==
                                                      'MART'
                                                  ? const Icon(
                                                      Icons
                                                          .shopping_bag_rounded,
                                                      color: Color(0xFF3978EF))
                                                  : controller
                                                              .ordersByDate[
                                                                  index]
                                                              .orderType ==
                                                          'DELIVERY'
                                                      ? const Icon(
                                                          CupertinoIcons.gift,
                                                          color:
                                                              Color(0xFF3978EF))
                                                      : const SizedBox(),
                                  Text(
                                    DateFormat("dd MMMM yyyy").format(controller
                                        .ordersByDate[index].createdAt!),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                  Text(
                                    '${controller.ordersByDate[index].customer?.id}',
                                    style: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                            .ordersByDate[index].totalAmount,
                                        0),
                                    style: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        fontSize: 12),
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
                            Visibility(
                                visible:
                                    controller.ordersByDate[index].orderType ==
                                                "FOOD" ||
                                            controller.ordersByDate[index]
                                                    .orderType ==
                                                "MART"
                                        ? true
                                        : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Card(
                                    elevation: 5,
                                    surfaceTintColor: const Color(0xFF3978EF),
                                    child: CarouselSlider.builder(
                                      itemCount: controller.ordersByDate[index]
                                          .orderItems?.length,
                                      options: CarouselOptions(
                                          height: 100,
                                          viewportFraction: 1,
                                          autoPlay: false),
                                      itemBuilder:
                                          (context, indexImg, realIndex) => Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: CachedNetworkImage(
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                                imageUrl: controller
                                                    .ordersByDate[index]
                                                    .orderItems![indexImg]
                                                    .product!
                                                    .image!),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "Nama pesanan",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                controller
                                                    .ordersByDate[index]
                                                    .orderItems![indexImg]
                                                    .product!
                                                    .name!,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "Harga",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                convertToIdr(
                                                    controller
                                                        .ordersByDate[index]
                                                        .orderItems![indexImg]
                                                        .product!
                                                        .price!,
                                                    0),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 10),
                                            child: Text(
                                              "${controller.ordersByDate[index].orderItems![indexImg].quantity}X",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            Visibility(
                                visible: controller.ordersByDate[index]
                                                .orderType ==
                                            "BIKE" ||
                                        controller.ordersByDate[index]
                                                .orderType ==
                                            "CAR" ||
                                        controller.ordersByDate[index]
                                                .orderType ==
                                            "DELIVERY"
                                    ? true
                                    : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          const Icon(CupertinoIcons.placemark,
                                              color: Color(0xFF3978EF)),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: Get.width * 0.75,
                                            child: Text(
                                              "${controller.ordersByDate[index].orderDetail?.address}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.readexPro(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: <Widget>[
                                          const Icon(CupertinoIcons.placemark,
                                              color: Colors.deepOrange),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: Get.width * 0.75,
                                            child: Text(
                                              controller
                                                      .ordersByDate[index]
                                                      .orderDetail
                                                      ?.dstAddress ??
                                                  '-',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.readexPro(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        } else if (controller.loading.value == Status.failed) {
          return Center(
            child: Text(
              "Tidak Ada Histori Order.\n Silahkan Melakukan Order untuk melihat histori order anda",
              style: GoogleFonts.readexPro(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Center(
              child: Text(
            "Anda tidak pernah melakukan pesanan apapun",
            style: GoogleFonts.readexPro(fontSize: 20),
          ));
        }
      }),
    );
  }
}
