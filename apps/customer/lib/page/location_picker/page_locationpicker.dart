import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lugo_customer/api/local_service.dart';
import 'package:lugo_customer/page/location_picker/controller_locationpicker.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:lugo_customer/shared/utils.dart';

class PageLocationPicker extends GetView<ControllerLocationPicker> {
  const PageLocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
            onTap: () => Get.offNamed(Routes.home),
            child: Card(
              elevation: 0,
              color: const Color(0xFF3978EF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: const Center(
                child: Icon(Icons.chevron_left, size: 24, color: Colors.white),
              ),
            )),
        actions: [
          InkWell(
              onTap: () => Get.toNamed(Routes.discount),
              child: SizedBox(
                width: 55,
                height: 55,
                child: Card(
                  elevation: 0,
                  color: const Color(0xFF3978EF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: const Center(
                    child: Icon(Icons.list_alt, size: 24, color: Colors.white),
                  ),
                ),
              )),
        ],
      ),
      body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (didPop) {return;}
            Get.offNamed(Routes.home);
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Obx(() => GoogleMap(
                      mapType: MapType.terrain,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      onTap: (argument) {
                        controller.rute.clear();
                        controller.setDestination(argument);
                        controller.secondStep(false);
                        controller.firstStep(true);
                      },
                      onMapCreated: (it) => controller.mapController.complete(it),
                      initialCameraPosition: CameraPosition(
                          zoom: 17,
                          target: LatLng(
                              controller.myLocation.value.latitude!,
                              controller.myLocation.value.longitude!
                          )),
                      markers: Set.from(controller.markers),
                      polylines: {
                        Polyline(
                            polylineId: const PolylineId("Rute Perjalanan"),
                            points: controller.rute.toList(),
                            color: const Color(0xFF3978EF),
                            width: 5,
                            geodesic: false)
                      })),
              DraggableScrollableSheet(
                maxChildSize: 0.8,
                minChildSize: 0.15,
                initialChildSize: 0.15,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Obx(() => Column(
                            children: <Widget>[
                              //first_step
                              Visibility(
                                visible: controller.firstStep.value,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        var trans = await LocalService()
                                            .getTransactionId();
                                        var service = await LocalService()
                                            .getRequestType();

                                        log("$trans \n$service");
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 5,
                                          fixedSize: Size(
                                              Get.width, Get.height * 0.05),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          backgroundColor: Colors.white),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Icon(Icons.location_on_rounded,
                                              color: Color(0xFF3978EF)),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              "Lokasi Saya",
                                              style: GoogleFonts.readexPro(
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              Visibility(
                                visible: controller.firstStep.value,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: SizedBox(
                                    width: Get.width,
                                    height: 60,
                                    child: TextFormField(
                                      style:
                                          GoogleFonts.readexPro(fontSize: 12),
                                      controller: controller.edtPickUp,
                                      decoration: InputDecoration(
                                        hintText: 'Detail alamat',
                                        labelStyle: GoogleFonts.readexPro(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF95A1AC),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF4B39EF))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.grey)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF1D2428))),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.red)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.firstStep.value,
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                  child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Colors.black26,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.firstStep.value,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          elevation: 5,
                                          fixedSize: Size(
                                              Get.width, Get.height * 0.05),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          backgroundColor: Colors.white),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          const Icon(Icons.location_on_rounded,
                                              color: Colors.deepOrangeAccent),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              "Lokasi Tujuan",
                                              style: GoogleFonts.readexPro(
                                                  fontSize: 14,
                                                  color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                              Visibility(
                                visible: controller.firstStep.value,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                  child: SizedBox(
                                    width: Get.width,
                                    height: 60,
                                    child: TextFormField(
                                      style:
                                          GoogleFonts.readexPro(fontSize: 12),
                                      controller: controller.edtDropOff,
                                      decoration: InputDecoration(
                                        hintText: 'Detail alamat',
                                        labelStyle: GoogleFonts.readexPro(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF95A1AC),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF4B39EF))),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.grey)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Color(0xFF1D2428))),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.red)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.firstStep.value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (controller.requestType.value ==
                                                'BIKE' ||
                                            controller.requestType.value ==
                                                'CAR') {
                                          controller.firstStep(false);
                                          controller.secondStep(true);
                                          controller.setRoutes();
                                        } else {
                                          controller.firstStep(false);
                                          controller.deliveryStep(true);
                                          controller.setRoutes();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          fixedSize: Size(
                                              Get.width, Get.height * 0.06),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          backgroundColor:
                                              const Color(0xFF3978EF)),
                                      child: Text(
                                        "Cek",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ),
                              ),
                              //second_step
                              Visibility(
                                visible: controller.secondStep.value,
                                child: Container(
                                  width: Get.width,
                                  height: Get.height * 0.07,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        controller.requestType.value == 'BIKE'
                                            ? Icons.directions_bike_rounded
                                            : Icons.drive_eta_rounded,
                                        color: const Color(0xFF3978EF),
                                        size: 24.0,
                                      ),
                                      controller.priceLoading.value == false
                                          ? Text(
                                              '${controller.distance.value} km',
                                              style: GoogleFonts.readexPro(
                                                fontSize: 18,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : const CircularProgressIndicator(),
                                      Text(
                                        convertToIdr(controller.price.value, 0),
                                        style: GoogleFonts.readexPro(
                                          fontSize: 18,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.secondStep.value,
                                child: Container(
                                  height: 50,
                                  width: Get.width,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          width: 1, color: Colors.black54)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 50,
                                        width: Get.width * 0.63,
                                        child: TextFormField(
                                          style: GoogleFonts.readexPro(
                                              fontSize: 12),
                                          controller: controller.edtDiscount,
                                          decoration: InputDecoration(
                                              hintText: 'Kode diskon',
                                              labelStyle: GoogleFonts.readexPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: const Color(0xFF95A1AC),
                                              ),
                                              errorBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedErrorBorder:
                                                  InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10)),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                fixedSize: Size(
                                                    Get.width * 0.28,
                                                    Get.height * 0.03),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                backgroundColor:
                                                    const Color(0xFF3978EF)),
                                            child: Text(
                                              "Gunakan",
                                              style: GoogleFonts.readexPro(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.secondStep.value,
                                child: Container(
                                  height: 50,
                                  width: Get.width,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade300)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Biaya',
                                        style: GoogleFonts.readexPro(
                                          fontSize: 18,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        convertToIdr(controller.price.value, 0),
                                        style: GoogleFonts.readexPro(
                                          fontSize: 18,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.secondStep.value,
                                child: Container(
                                  height: 50,
                                  width: Get.width,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade300)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Cash',
                                        style: GoogleFonts.readexPro(
                                          fontSize: 18,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      DropdownButton<String>(
                                        elevation: 2,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF95A1AC),
                                          size: 24,
                                        ),
                                        value: controller.payType.value,
                                        borderRadius: BorderRadius.circular(8),
                                        underline: const SizedBox(),
                                        items: controller.payTypeList
                                            .map((element) {
                                          return DropdownMenuItem(
                                            value: element,
                                            child: Text(
                                              element,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) =>
                                            controller.payType(value),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.secondStep.value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (controller.requestType.value == 'BIKE' ||
                                            controller.requestType.value == 'CAR') {
                                          if(controller.payType.value == "DANA"){
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog.adaptive(
                                                backgroundColor: Colors.white,
                                                surfaceTintColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12)
                                                ),
                                                content: const Image(
                                                  image: AssetImage('assets/images/coming_soon.jpg'),
                                                ),
                                              ),
                                            );
                                          }else if(controller.payType.value == "Pembayaran"){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text("Anda belum memilih metode pembayaran"))
                                            );
                                          }else{
                                            controller.createBikeCarOrder();
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          fixedSize: Size(Get.width, Get.height * 0.06),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12)),
                                          backgroundColor:const Color(0xFF3978EF)),
                                      child: Text(
                                        "Lanjutkan",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ),
                              ),
                              //delivary_step
                              Visibility(
                                visible: controller.deliveryStep.value,
                                child: Container(
                                  width: Get.width,
                                  height: Get.height * 0.07,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.redeem_rounded,
                                        color: Color(0xFF3978EF),
                                        size: 24.0,
                                      ),
                                      controller.priceLoading.value == false
                                          ? Text(
                                              '${controller.distance.value} km',
                                              style: GoogleFonts.readexPro(
                                                fontSize: 18,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : const CircularProgressIndicator(),
                                      Text(
                                        convertToIdr(controller.price.value, 0),
                                        style: GoogleFonts.readexPro(
                                          fontSize: 18,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.deliveryStep.value,
                                child: Container(
                                  height: 50,
                                  width: Get.width,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextFormField(
                                    style: GoogleFonts.readexPro(fontSize: 12),
                                    controller: controller.edtPackage,
                                    decoration: InputDecoration(
                                        hintText: 'Apa isi paket kamu?',
                                        labelStyle: GoogleFonts.readexPro(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF95A1AC),
                                        ),
                                        errorBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10)),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.deliveryStep.value,
                                child: Container(
                                  height: 50,
                                  width: Get.width,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: TextFormField(
                                    style: GoogleFonts.readexPro(fontSize: 12),
                                    controller: controller.edtWeight,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: 'Berat paket kamu?',
                                        labelStyle: GoogleFonts.readexPro(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xFF95A1AC),
                                        ),
                                        errorBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10)),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.deliveryStep.value,
                                child: Container(
                                  height: 50,
                                  width: Get.width,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          width: 1, color: Colors.black54)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 50,
                                        width: Get.width * 0.63,
                                        child: TextFormField(
                                          style: GoogleFonts.readexPro(
                                              fontSize: 12),
                                          controller: controller.edtDiscount,
                                          decoration: InputDecoration(
                                              hintText: 'Kode diskon',
                                              labelStyle: GoogleFonts.readexPro(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: const Color(0xFF95A1AC),
                                              ),
                                              errorBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedErrorBorder:
                                                  InputBorder.none,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10)),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6),
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                fixedSize: Size(
                                                    Get.width * 0.28,
                                                    Get.height * 0.03),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                backgroundColor:
                                                    const Color(0xFF3978EF)),
                                            child: Text(
                                              "Gunakan",
                                              style: GoogleFonts.readexPro(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.deliveryStep.value,
                                child: Container(
                                  height: 50,
                                  width: Get.width,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade300)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Biaya',
                                        style: GoogleFonts.readexPro(
                                          fontSize: 18,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        convertToIdr(controller.price.value, 0),
                                        style: GoogleFonts.readexPro(
                                          fontSize: 18,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.deliveryStep.value,
                                child: Container(
                                  height: 50,
                                  width: Get.width,
                                  margin:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade300)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Pembayaran',
                                        style: GoogleFonts.readexPro(
                                          fontSize: 18,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      DropdownButton<String>(
                                        elevation: 2,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Color(0xFF95A1AC),
                                          size: 24,
                                        ),
                                        value: controller.payType.value,
                                        borderRadius: BorderRadius.circular(8),
                                        underline: const SizedBox(),
                                        items: controller.payTypeList
                                            .map((element) {
                                          return DropdownMenuItem(
                                            value: element,
                                            child: Text(
                                              element,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) =>
                                            controller.payType(value),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: controller.deliveryStep.value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (controller.requestType.value == 'DELIVERY') {
                                          if(controller.payType.value == "DANA"){
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog.adaptive(
                                                backgroundColor: Colors.white,
                                                surfaceTintColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12)
                                                ),
                                                content: const Image(
                                                  image: AssetImage('assets/images/coming_soon.jpg'),
                                                ),
                                              ),
                                            );
                                          }else if(controller.payType.value == "Pembayaran"){
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text("Anda belum memilih metode pembayaran"))
                                            );
                                          }else{
                                            controller.createDeliveryOrder();
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          fixedSize: Size(
                                              Get.width, Get.height * 0.06),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          backgroundColor:
                                              const Color(0xFF3978EF)),
                                      child: Text(
                                        "Lanjutkan",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3978EF),
        onPressed: () => controller.initialLocation(),
        child: const Icon(
          Icons.circle_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
