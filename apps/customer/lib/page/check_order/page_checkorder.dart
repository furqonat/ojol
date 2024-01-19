import 'dart:developer';

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lugo_customer/page/check_order/controller_checkorder.dart';
import 'package:lugo_customer/route/route_name.dart';

class PageCheckOrder extends GetView<ControllerCheckOrder> {
  const PageCheckOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          leading: InkWell(
              onTap: () => Get.back(),
              child: Card(
                elevation: 0,
                color: const Color(0xFF3978EF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: const Center(
                  child:
                      Icon(Icons.chevron_left, size: 24, color: Colors.white),
                ),
              )),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            const GoogleMap(
                mapType: MapType.terrain,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                    zoom: 15, target: LatLng(-7.8032485, 110.3336448))),
            DraggableScrollableSheet(
              maxChildSize: 0.8,
              minChildSize: 0.13,
              initialChildSize: 0.13,
              builder: (context, scrollController) {
                return Container(
                  width: Get.width,
                  height: Get.height * 0.48,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Row(
                                children: <Widget>[
                                  const Image(
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          'assets/images/2023-05-05_(4).png')),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'User name',
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'B xxxx AA',
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        'Mio J',
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      AnimatedRatingStars(
                                        starSize: 10,
                                        readOnly: true,
                                        initialRating: 2,
                                        onChanged: (p0) {},
                                        customEmptyIcon: Icons.star,
                                        customFilledIcon: Icons.star,
                                        customHalfFilledIcon: Icons.star,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
                              child: Text(
                                'ID Transaksi | 123xxxxxx',
                                style: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
                              child: Text(
                                'ID Order | 123xxxxxx',
                                style: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  controller.requestType.value == 'delivery'
                                      ? true
                                      : false,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 5, 25, 0),
                                child: Text(
                                  'Isi paket | Baju muslim',
                                  style: GoogleFonts.readexPro(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
                              child: Center(
                                child: Text(
                                  'Rp 10.000 | Cash',
                                  style: GoogleFonts.readexPro(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
                              child: Center(
                                child: Text(
                                  'Sedang Mejemput Anda',
                                  style: GoogleFonts.readexPro(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF3978EF),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 15, 10, 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () =>
                                        log(controller.requestType.value),
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.message_rounded,
                                          size: 30,
                                          color: Colors.grey.shade500,
                                        ),
                                        Text(
                                          'Pesan',
                                          style: GoogleFonts.readexPro(
                                            fontSize: 12,
                                            color: Colors.black87,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 50,
                                    color: Colors.grey,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.phone_rounded,
                                        size: 30,
                                        color: Colors.grey.shade500,
                                      ),
                                      Text(
                                        'Telepon',
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: 1,
                                    height: 50,
                                    color: Colors.grey,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.help,
                                        size: 30,
                                        color: Colors.grey.shade500,
                                      ),
                                      Text(
                                        'Bantuan',
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                          color: Colors.black87,
                                        ),
                                      )
                                    ],
                                  ),
                                  Visibility(
                                    visible: controller.requestType.value ==
                                                'food' ||
                                            controller.requestType.value ==
                                                'mart'
                                        ? true
                                        : false,
                                    child: Container(
                                      width: 1,
                                      height: 50,
                                      color: Colors.grey,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                    ),
                                  ),
                                  Visibility(
                                    visible: controller.requestType.value ==
                                                'food' ||
                                            controller.requestType.value ==
                                                'mart'
                                        ? true
                                        : false,
                                    child: Column(
                                      children: <Widget>[
                                        Icon(
                                          Icons.list_rounded,
                                          size: 30,
                                          color: Colors.grey.shade500,
                                        ),
                                        Text(
                                          'Pesanan',
                                          style: GoogleFonts.readexPro(
                                            fontSize: 12,
                                            color: Colors.black87,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: controller.cancelStatus.value,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (controller.requestType.value ==
                                              'rider' ||
                                          controller.requestType.value ==
                                              'driver') {
                                        Get.offAndToNamed(Routes.order_finish);
                                      } else if (controller.requestType.value ==
                                          'delivery') {
                                        Get.offAndToNamed(
                                            Routes.delivery_finish);
                                      } else {
                                        Get.offAndToNamed(Routes.food_finish);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        fixedSize:
                                            Size(Get.width, Get.height * 0.05),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        backgroundColor: Colors.orange),
                                    child: Text(
                                      "Batalkan",
                                      style: GoogleFonts.readexPro(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                            )
                          ],
                        )),
                  ),
                );
              },
            )
          ],
        ));
  }
}
