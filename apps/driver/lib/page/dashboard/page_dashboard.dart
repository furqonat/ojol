import 'dart:developer';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lugo_driver/route/route_name.dart';
import '../../shared/custom_widget/lugo_button.dart';
import '../../shared/utils.dart';
import 'controller_dashboard.dart';

class PageDashboard extends GetView<ControllerDashboard> {
  const PageDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Obx(
        () => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // GoogleMap(
            //   mapType: MapType.terrain,
            //   zoomGesturesEnabled: true,
            //   zoomControlsEnabled: false,
            //   onMapCreated: (it) => controller.mapController.complete(it),
            //   initialCameraPosition: CameraPosition(
            //     zoom: 17,
            //     target: LatLng(
            //       controller.locationData.value.latitude ?? -7.8032485,
            //       controller.locationData.value.longitude ?? 110.3336448,
            //     ),
            //   ),
            //   polylines: {
            //     Polyline(
            //       polylineId: const PolylineId("Rute Perjalanan"),
            //       points: controller.rute.toList(),
            //       color: const Color(0xFF3978EF),
            //       width: 5,
            //       geodesic: false,
            //     )
            //   },
            //   markers: {
            //     Marker(
            //       markerId: const MarkerId("Lokasi saya"),
            //       position: LatLng(
            //         controller.locationData.value.latitude!,
            //         controller.locationData.value.longitude!,
            //       ),
            //       icon: BitmapDescriptor.defaultMarkerWithHue(
            //         BitmapDescriptor.hueRed,
            //       ),
            //     )
            //   },
            // ),
            const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  -7.8032485,
                  110.3336448,
                ),
              ),
            ),
            Visibility(
              visible: controller.showBottomSheet.value,
              child: DraggableScrollableSheet(
                maxChildSize: 0.8,
                minChildSize: 0.13,
                initialChildSize: 0.13,
                builder: (context, scrollController) => Container(
                  width: Get.width,
                  height: Get.height * 0.48,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  child: Obx(
                    () => CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Visibility(
                            visible: controller.showPickUpLocation.value,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Lokasi Jemput",
                                        style: GoogleFonts.readexPro(
                                            fontSize: 20,
                                            color: const Color(0xFF3978EF),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.location_pin,
                                          color: Color(0xFF3978EF))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "${controller.order.value.customerId}",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Spacer(),
                                      // AnimatedRatingStars(
                                      //     starSize: 20,
                                      //     onChanged: (p0) {},
                                      //     customFilledIcon: Icons.star_rounded,
                                      //     customHalfFilledIcon: Icons.star_rounded,
                                      //     customEmptyIcon: Icons.star_rounded
                                      // )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Order ID",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${controller.order.value.orderDetail?.id}",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Biaya",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${convertToIdr(controller.order.value.totalAmount, 0)} / Cash",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  height: Get.height * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(0xFF3978EF),
                                      )),
                                  padding: const EdgeInsets.all(10),
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  child: Text(
                                    "${controller.order.value.orderDetail?.address}",
                                    style: GoogleFonts.readexPro(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {},
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
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
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
                                    ),
                                    Container(
                                      width: 1,
                                      height: 50,
                                      color: Colors.grey,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
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
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      LugoButton(
                                          textButton: 'Sudah Sampai',
                                          textColor: Colors.white,
                                          textSize: 12,
                                          width: Get.width * 0.45,
                                          height: Get.height * 0.06,
                                          color: const Color(0xFF3978EF),
                                          onTap: () {
                                            controller
                                                .showPickUpLocation(false);
                                            controller
                                                .showDropDownLocation(true);
                                          }),
                                      LugoButton(
                                          textButton: 'Batalkan',
                                          textColor: Colors.white,
                                          textSize: 12,
                                          width: Get.width * 0.45,
                                          height: Get.height * 0.06,
                                          color: Colors.deepOrange,
                                          onTap: () {}),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Visibility(
                            visible: controller.showDropDownLocation.value,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Lokasi Antar",
                                        style: GoogleFonts.readexPro(
                                            fontSize: 20,
                                            color: Colors.deepOrange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.location_pin,
                                          color: Colors.deepOrange)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "${controller.order.value.customerId}",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Spacer(),
                                      AnimatedRatingStars(
                                          starSize: 20,
                                          onChanged: (p0) {},
                                          customFilledIcon: Icons.star_rounded,
                                          customHalfFilledIcon:
                                              Icons.star_rounded,
                                          customEmptyIcon: Icons.star_rounded)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Order ID",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${controller.order.value.orderDetail?.id}",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Biaya",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${convertToIdr(controller.order.value.totalAmount, 0)} / Cash",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Get.width,
                                  height: Get.height * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.deepOrange,
                                      )),
                                  padding: const EdgeInsets.all(10),
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  child: Text(
                                    "${controller.order.value.orderDetail?.dstAddress}",
                                    style: GoogleFonts.readexPro(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {},
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
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
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
                                    ),
                                    Container(
                                      width: 1,
                                      height: 50,
                                      color: Colors.grey,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
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
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: LugoButton(
                                      textButton: 'Sudah Sampai',
                                      textColor: Colors.white,
                                      textSize: 12,
                                      width: Get.width * 0.45,
                                      height: Get.height * 0.06,
                                      color: const Color(0xFF3978EF),
                                      onTap: () {
                                        controller.showBottomSheet(false);
                                        controller.showPickUpLocation(true);
                                        controller.showDropDownLocation(false);
                                        Get.toNamed(Routes.orderFinish);
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.orderDialog(context),
        backgroundColor: const Color(0xFF3978EF),
        child: const Icon(CupertinoIcons.settings, color: Colors.white),
      ),
    );
  }
}
