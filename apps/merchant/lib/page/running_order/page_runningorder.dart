import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/running_order/controller_runningorder.dart';
import 'package:lugo_marchant/shared/custom_widget/lugo_btn.dart';
import 'package:lugo_marchant/shared/utils.dart';

class PageRunningOrder extends GetView<ControllerRunningOrder> {
  const PageRunningOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Order"),
      ),
      body: Obx(
        () => Column(
          children: [
            TabBar(
              labelColor: const Color(0xFF14181B),
              indicatorColor: const Color(0xFF4B39EF),
              labelStyle: GoogleFonts.readexPro(),
              padding: const EdgeInsets.only(top: 20),
              unselectedLabelStyle: GoogleFonts.readexPro(
                color: const Color(0xFF95A1AC),
              ),
              controller: controller.tabController,
              tabs: const [
                Tab(
                  text: 'Baru',
                ),
                Tab(
                  text: 'Proses',
                ),
                Tab(
                  text: 'Selesai',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  SizedBox(
                    height: Get.height,
                    child: Column(
                      children: controller.newOrder.map((element) {
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
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
                                          10, 10, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'ID Order | ${element['id']}',
                                            style: GoogleFonts.readexPro(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          AnimatedRatingStars(
                                            starSize: 16,
                                            readOnly: true,
                                            initialRating: 5,
                                            onChanged: (p0) {},
                                            customEmptyIcon: Icons.star_rounded,
                                            customFilledIcon:
                                                Icons.star_rounded,
                                            customHalfFilledIcon:
                                                Icons.star_rounded,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Nama Customer',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${element['customer']['name']}',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    element['driver'] != null
                                        ? Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      'Nama Driver',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${element['driver']['name']}',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      'Plat Nomor',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${element['driver']['driver_details']['vehicle']['vehicle_rn']}',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      'Kendaraan',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${element['driver']['driver_details']['vehicle']['vehicle_brand']}',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    ...(element['order_items'] as List<dynamic>)
                                        .map(
                                      (e) {
                                        final data = e as Map<String, dynamic>;
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    '${data['product']['name']}',
                                                    style:
                                                        GoogleFonts.readexPro(
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  Text(
                                                    intlNumberCurrency(
                                                      data['product']['price'] *
                                                          data['quantity'],
                                                    ),
                                                    style:
                                                        GoogleFonts.readexPro(
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${data['quantity']}x',
                                                    style:
                                                        GoogleFonts.readexPro(
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'PPN',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.red,
                                            ),
                                          ),
                                          Text(
                                            'Rp 0',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Potongan jasa',
                                            style: GoogleFonts.readexPro(
                                              color: const Color(0xFF3978EF),
                                            ),
                                          ),
                                          Text(
                                            'Rp 0',
                                            style: GoogleFonts.readexPro(
                                              color: const Color(0xFF3978EF),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Total',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            intlNumberCurrency(
                                              element['gross_amount'],
                                            ),
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              LugoButton(
                                  textButton: 'Terima',
                                  textColor: Colors.white,
                                  textSize: 12,
                                  width: Get.width * 0.45,
                                  height: Get.height * 0.06,
                                  color: const Color(0xFF3978EF),
                                  onTap: () {
                                    controller.handleAcceptOrder(element['id']);
                                  }),
                              LugoButton(
                                  textButton: 'Habis',
                                  textColor: Colors.white,
                                  textSize: 12,
                                  width: Get.width * 0.45,
                                  height: Get.height * 0.06,
                                  color: const Color(0xFF3978EF),
                                  onTap: () {
                                    controller.handleReject(element['id']);
                                  }),
                            ],
                          )
                        ]);
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: Get.height,
                    child: Column(
                      children: controller.proccess.map((element) {
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
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
                                          10, 10, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'ID Order | ${element['id']}',
                                            style: GoogleFonts.readexPro(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          AnimatedRatingStars(
                                            starSize: 16,
                                            readOnly: true,
                                            initialRating: 5,
                                            onChanged: (p0) {},
                                            customEmptyIcon: Icons.star_rounded,
                                            customFilledIcon:
                                                Icons.star_rounded,
                                            customHalfFilledIcon:
                                                Icons.star_rounded,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Nama Customer',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${element['customer']['name']}',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    element['driver'] != null
                                        ? Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      'Nama Driver',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${element['driver']['name']}',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      'Plat Nomor',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${element['driver']['driver_details']['vehicle']['vehicle_rn']}',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 5, 10, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      'Kendaraan',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${element['driver']['driver_details']['vehicle']['vehicle_brand']}',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    ...(element['order_items'] as List<dynamic>)
                                        .map(
                                      (e) {
                                        final data = e as Map<String, dynamic>;
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    '${data['product']['name']}',
                                                    style:
                                                        GoogleFonts.readexPro(
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  Text(
                                                    intlNumberCurrency(
                                                      data['product']['price'] *
                                                          data['quantity'],
                                                    ),
                                                    style:
                                                        GoogleFonts.readexPro(
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${data['quantity']}x',
                                                    style:
                                                        GoogleFonts.readexPro(
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'PPN',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.red,
                                            ),
                                          ),
                                          Text(
                                            'Rp 0',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Potongan jasa',
                                            style: GoogleFonts.readexPro(
                                              color: const Color(0xFF3978EF),
                                            ),
                                          ),
                                          Text(
                                            'Rp 0',
                                            style: GoogleFonts.readexPro(
                                              color: const Color(0xFF3978EF),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Total',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            intlNumberCurrency(
                                              element['gross_amount'],
                                            ),
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: Get.height,
                    child: Column(
                      children: controller.done.map((element) {
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
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
                                          10, 10, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'ID Order | ${element['id']}',
                                            style: GoogleFonts.readexPro(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          AnimatedRatingStars(
                                            starSize: 16,
                                            readOnly: true,
                                            initialRating: 5,
                                            onChanged: (p0) {},
                                            customEmptyIcon: Icons.star_rounded,
                                            customFilledIcon:
                                                Icons.star_rounded,
                                            customHalfFilledIcon:
                                                Icons.star_rounded,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Nama Customer',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${element['customer']['name']}',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Nama Driver',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${element['driver']['name']}',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Plat Nomor',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${element['driver']['driver_details']['vehicle']['vehicle_rn']}',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Kendaraan',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${element['driver']['driver_details']['vehicle']['vehicle_brand']}',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    ...(element['order_items'] as List<dynamic>)
                                        .map(
                                      (e) {
                                        final data = e as Map<String, dynamic>;
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    '${data['product']['name']}',
                                                    style:
                                                        GoogleFonts.readexPro(
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  Text(
                                                    intlNumberCurrency(
                                                      data['product']['price'] *
                                                          data['quantity'],
                                                    ),
                                                    style:
                                                        GoogleFonts.readexPro(
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${data['quantity']}x',
                                                    style:
                                                        GoogleFonts.readexPro(
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'PPN',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.red,
                                            ),
                                          ),
                                          Text(
                                            'Rp 0',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Potongan jasa',
                                            style: GoogleFonts.readexPro(
                                              color: const Color(0xFF3978EF),
                                            ),
                                          ),
                                          Text(
                                            'Rp 0',
                                            style: GoogleFonts.readexPro(
                                              color: const Color(0xFF3978EF),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Total',
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            intlNumberCurrency(
                                              element['gross_amount'],
                                            ),
                                            style: GoogleFonts.readexPro(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
