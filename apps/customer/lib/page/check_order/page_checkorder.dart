import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:lugo_customer/api/local_service.dart';
import 'package:lugo_customer/page/check_order/controller_checkorder.dart';
import 'package:lugo_customer/response/driver.dart';
import 'package:lugo_customer/response/live_transaction.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:lugo_customer/shared/utils.dart';

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
              onTap: () => Get.offNamed(Routes.home),
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
        body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (didPop) {
              return;
            }
            Get.offNamed(Routes.home);
          },
          child: StreamBuilder<LiveTransaction?>(
              stream: controller.trackTransaction(),
              builder: (context, transSnapshot) {
                if (transSnapshot.data?.driverId != null) {
                  if (transSnapshot.data?.orderType == 'BIKE' &&
                          transSnapshot.data?.status == 'DONE' ||
                      transSnapshot.data?.orderType == 'CAR' &&
                          transSnapshot.data?.status == 'DONE') {
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => Get.toNamed(Routes.orderFinish, arguments: {
                              'id_driver': controller.driver.value.id,
                              'id_trans': transSnapshot.data?.id,
                              'id_order': controller.orderId.value,
                              'pay_type': transSnapshot.data?.paymentType,
                              'price': controller.price.value,
                            }));
                  } else if (transSnapshot.data?.orderType == 'FOOD' &&
                          transSnapshot.data?.status == 'DONE' ||
                      transSnapshot.data?.orderType == 'MART' &&
                          transSnapshot.data?.status == 'DONE') {
                    WidgetsBinding.instance.addPostFrameCallback(
                        (_) => Get.toNamed(Routes.foodFinish));
                  } else if (transSnapshot.data?.orderType == 'DELIVERY' &&
                      transSnapshot.data?.status == 'DONE') {
                    WidgetsBinding.instance.addPostFrameCallback((_) =>
                        Get.toNamed(Routes.deliveryFinish, arguments: {
                          "price": controller.price.value,
                          "payment_type": transSnapshot.data?.paymentType
                        }));
                  } else {
                    log('');
                  }
                  controller.findDriverDetail(transSnapshot.data?.driverId);

                  return StreamBuilder<List<Driver>>(
                    stream:
                        controller.listenLocation(transSnapshot.data?.driverId),
                    builder: (context, driverSnapshot) {
                      var orderStatus = transSnapshot.data?.status;
                      switch (orderStatus) {
                        case 'DRIVER_OTW':
                          controller.markers.removeWhere((element) =>
                              element.markerId.value ==
                              const MarkerId("Driver").value);
                          controller.markers.add(Marker(
                              markerId: const MarkerId("Driver"),
                              icon: controller.customIcon,
                              position: LatLng(
                                  driverSnapshot.data?.first.latitude ?? 0.0,
                                  driverSnapshot.data?.first.latitude ?? 0.0)));
                          controller.rute.clear();
                          controller.setRoutes(
                              driverSnapshot.data?.first.latitude ?? 0.0,
                              driverSnapshot.data?.first.longitude ?? 0.0,
                              controller.myLocation.value.latitude,
                              controller.myLocation.value.longitude);
                          break;
                        case 'OTW':
                          controller.markers.removeWhere((element) =>
                              element.markerId.value ==
                              const MarkerId("Saya").value);
                          controller.markers.removeWhere((element) =>
                              element.markerId.value ==
                              const MarkerId("Driver").value);
                          controller.markers.add(Marker(
                              markerId: const MarkerId("Driver"),
                              icon: controller.customIcon,
                              position: LatLng(
                                  double.parse(
                                      "${driverSnapshot.data?.first.latitude}"),
                                  double.parse(
                                      "${driverSnapshot.data?.first.longitude}"))));
                          controller.rute.clear();
                          controller.setRoutes(
                              driverSnapshot.data?.first.latitude,
                              driverSnapshot.data?.first.longitude,
                              controller.destinationLocation.value.latitude,
                              controller.destinationLocation.value.longitude);
                          controller.initialLocation(
                              driverSnapshot.data?.first.latitude,
                              driverSnapshot.data?.first.longitude);
                          break;
                        default:
                          log('order selesai');
                      }

                      if (transSnapshot.hasData &&
                          transSnapshot.data != null &&
                          driverSnapshot.hasData &&
                          driverSnapshot.data != null) {
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            Obx(() => GoogleMap(
                                    mapType: MapType.terrain,
                                    zoomGesturesEnabled: true,
                                    zoomControlsEnabled: false,
                                    onMapCreated: (it) =>
                                        controller.mapController.complete(it),
                                    initialCameraPosition: CameraPosition(
                                        zoom: 17,
                                        target: LatLng(
                                            controller
                                                .myLocation.value.latitude!,
                                            controller
                                                .myLocation.value.longitude!)),
                                    markers: Set.from(controller.markers),
                                    polylines: {
                                      Polyline(
                                          polylineId: const PolylineId(
                                              "Rute Perjalanan"),
                                          points: controller.rute.toList(),
                                          color: const Color(0xFF3978EF),
                                          width: 5,
                                          geodesic: false)
                                    })),
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
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20))),
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      child: Obx(() => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 10, 0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      CachedNetworkImage(
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.contain,
                                                        imageUrl: controller
                                                                .driver
                                                                .value
                                                                .avatar ??
                                                            '',
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Image(
                                                                width: 100,
                                                                height: 100,
                                                                fit: BoxFit
                                                                    .contain,
                                                                image: AssetImage(
                                                                    'assets/images/2023-05-05_(4).png')),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            '${controller.driver.value.name}',
                                                            style: GoogleFonts
                                                                .readexPro(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${controller.driver.value.driverDetails?.vehicle?.vehicleRn}',
                                                            style: GoogleFonts
                                                                .readexPro(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${controller.driver.value.driverDetails?.vehicle?.vehicleBrand}',
                                                            style: GoogleFonts
                                                                .readexPro(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          25, 5, 25, 0),
                                                  child: Text(
                                                    'ID Transaksi | ${transSnapshot.data?.id}',
                                                    style:
                                                        GoogleFonts.readexPro(
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          25, 5, 25, 0),
                                                  child: Text(
                                                    'ID Order | ${controller.orderId.value}',
                                                    style:
                                                        GoogleFonts.readexPro(
                                                      fontSize: 12,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: transSnapshot.data
                                                              ?.orderType ==
                                                          'DELIVERY'
                                                      ? true
                                                      : false,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(25, 5, 25, 0),
                                                    child: Text(
                                                      'Isi paket | Baju muslim',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        fontSize: 12,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          25, 20, 25, 0),
                                                  child: Center(
                                                    child: Text(
                                                      '${convertToIdr(controller.price.value, 0)} | ${transSnapshot.data?.paymentType}',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        fontSize: 12,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          25, 5, 25, 0),
                                                  child: Center(
                                                    child: Text(
                                                      'Sedang Mejemput Anda',
                                                      style:
                                                          GoogleFonts.readexPro(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color(
                                                            0xFF3978EF),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 15, 10, 15),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.toNamed(
                                                                Routes.chat,
                                                                arguments: {
                                                                  'orderTransaksiId':
                                                                      controller
                                                                          .orderId
                                                                          .value,
                                                                });
                                                          },
                                                          child: Column(
                                                            children: <Widget>[
                                                              Icon(
                                                                Icons
                                                                    .message_rounded,
                                                                size: 30,
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                              ),
                                                              Text(
                                                                'Pesan',
                                                                style: GoogleFonts
                                                                    .readexPro(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 1,
                                                          height: 50,
                                                          color: Colors.grey,
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async =>
                                                              await FlutterPhoneDirectCaller
                                                                  .callNumber(
                                                                      '082324640007'),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Icon(
                                                                Icons
                                                                    .phone_rounded,
                                                                size: 30,
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                              ),
                                                              Text(
                                                                'Telepon',
                                                                style: GoogleFonts
                                                                    .readexPro(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 1,
                                                          height: 50,
                                                          color: Colors.grey,
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () =>
                                                              controller
                                                                  .userHelp(
                                                                      context),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Icon(
                                                                Icons.help,
                                                                size: 30,
                                                                color: Colors
                                                                    .grey
                                                                    .shade500,
                                                              ),
                                                              Text(
                                                                'Bantuan',
                                                                style: GoogleFonts
                                                                    .readexPro(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: controller
                                                                          .requestType
                                                                          .value ==
                                                                      'FOOD' ||
                                                                  controller
                                                                          .requestType
                                                                          .value ==
                                                                      'MART'
                                                              ? true
                                                              : false,
                                                          child: Container(
                                                            width: 1,
                                                            height: 50,
                                                            color: Colors.grey,
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        20),
                                                          ),
                                                        ),
                                                        Visibility(
                                                            visible: controller
                                                                            .requestType
                                                                            .value ==
                                                                        'FOOD' ||
                                                                    controller
                                                                            .requestType
                                                                            .value ==
                                                                        'MART'
                                                                ? true
                                                                : false,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Icon(
                                                                  Icons
                                                                      .list_rounded,
                                                                  size: 30,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500,
                                                                ),
                                                                Text(
                                                                  'Pesanan',
                                                                  style: GoogleFonts
                                                                      .readexPro(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black87,
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                                      ]),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 25),
                                                  child: ElevatedButton(
                                                      onPressed: transSnapshot
                                                                      .data
                                                                      ?.status ==
                                                                  "CREATED" ||
                                                              transSnapshot.data
                                                                      ?.status ==
                                                                  "WAITING_MERCHANT" ||
                                                              transSnapshot.data
                                                                      ?.status ==
                                                                  "FIND_DRIVE"
                                                          ? () => controller
                                                              .cancelOrder()
                                                          : transSnapshot.data
                                                                          ?.status ==
                                                                      "DRIVER_CLOSE" ||
                                                                  transSnapshot
                                                                          .data
                                                                          ?.status ==
                                                                      "CANCELED" ||
                                                                  transSnapshot
                                                                          .data
                                                                          ?.status ==
                                                                      "EXPIRED"
                                                              ? () async {
                                                                  await LocalService()
                                                                      .orderFinish();
                                                                  WidgetsBinding
                                                                      .instance
                                                                      .addPostFrameCallback(
                                                                          (_) =>
                                                                              Get.offNamed(Routes.home));
                                                                }
                                                              : null,
                                                      style: ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          fixedSize: Size(Get.width, Get.height * 0.05),
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                          backgroundColor: transSnapshot.data?.status == "DRIVER_CLOSE" || transSnapshot.data?.status == "CANCELED" || transSnapshot.data?.status == "EXPIRED" ? Colors.red : Colors.orange,
                                                          disabledBackgroundColor: transSnapshot.data?.status == "OTW" || transSnapshot.data?.status == "DRIVER_OTW"
                                                              ? const Color(0xFF3978EF)
                                                              : transSnapshot.data?.status == "DRIVER_CLOSE" || transSnapshot.data?.status == "CANCELED" || transSnapshot.data?.status == "EXPIRED"
                                                                  ? Colors.red
                                                                  : const Color(0xFF3978EF)),
                                                      child: Text(
                                                        transSnapshot.data
                                                                    ?.status ==
                                                                "FIND_DRIVE"
                                                            ? "Driver Ditemukan"
                                                            : transSnapshot.data
                                                                        ?.status ==
                                                                    "DRIVER_OTW"
                                                                ? "Driver dalam perjalanan"
                                                                : transSnapshot
                                                                            .data
                                                                            ?.status ==
                                                                        "DONE"
                                                                    ? "Pesanan selesai"
                                                                    : transSnapshot.data?.status ==
                                                                            "OTW"
                                                                        ? "Pesanan berjalan"
                                                                        : transSnapshot.data?.status ==
                                                                                "WAITING_MERCHANT"
                                                                            ? "Menunggu toko"
                                                                            : transSnapshot.data?.status == "DRIVER_CLOSE" || transSnapshot.data?.status == "CANCELED" || transSnapshot.data?.status == "EXPIRED"
                                                                                ? "Kembali"
                                                                                : "Batalkan",
                                                        style: GoogleFonts
                                                            .readexPro(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      )),
                                                )
                                              ])),
                                    ),
                                  );
                                }),
                          ],
                        );
                      } else if (transSnapshot.hasError &&
                          driverSnapshot.hasError) {
                        return Center(
                          child: Text(
                            "Ada yang salah",
                            style: GoogleFonts.readexPro(fontSize: 14),
                          ),
                        );
                      } else {
                        return Center(
                          child: lottie.LottieBuilder.asset(
                              'assets/lottie/loading.json'),
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                    child: lottie.LottieBuilder.asset(
                        'assets/lottie/search_rider.json'),
                  );
                }
              }),
        ));
  }
}
