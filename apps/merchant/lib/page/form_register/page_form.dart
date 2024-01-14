import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lugo_marchant/page/form_register/controller_form.dart';

import '../../shared/custom_widget/lugo_btn.dart';

class PageForm extends GetView<ControllerForm> {
  const PageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Form Daftar",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Card(
            elevation: 0,
            color: const Color(0xFF3978EF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  autofocus: false,
                  controller: controller.edtFullName,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF95A1AC),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    labelStyle: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF4B39EF),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF1D2428),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                    ),
                    contentPadding: const EdgeInsets.all(24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  autofocus: false,
                  controller: controller.edtCompleteAddress,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF95A1AC),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Alamat Lengkap',
                    labelStyle: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF4B39EF),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF1D2428),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                    ),
                    contentPadding: const EdgeInsets.all(24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  controller: controller.edtPhone,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF95A1AC),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nomor Ponsel',
                    labelStyle: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF4B39EF),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF1D2428),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                    ),
                    contentPadding: const EdgeInsets.all(24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.edtEmail,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF95A1AC),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF4B39EF),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF1D2428),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                    ),
                    contentPadding: const EdgeInsets.all(24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  autofocus: false,
                  controller: controller.edtTypeTransport,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF95A1AC),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Jenis Kendaraan (Honda, Toyota, Daihatsu)',
                    labelStyle: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF4B39EF),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF1D2428),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                    ),
                    contentPadding: const EdgeInsets.all(24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  autofocus: false,
                  controller: controller.edtBrandTransport,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF95A1AC),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Merk Kendaraan (Xenia, Avanza, Brio)',
                    labelStyle: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF4B39EF),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF1D2428),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                    ),
                    contentPadding: const EdgeInsets.all(24),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  autofocus: false,
                  controller: controller.edtYearTransport,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF95A1AC),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Tahun Kendaraan',
                    labelStyle: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF4B39EF))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF1D2428))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.red)),
                    contentPadding: const EdgeInsets.all(24),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.25,
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Upload KTP',
                    style: GoogleFonts.readexPro(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3978EF),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.25,
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Upload Restoran 1',
                    style: GoogleFonts.readexPro(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3978EF),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: Get.width,
                  height: Get.height * 0.25,
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Upload Restoran 2',
                    style: GoogleFonts.readexPro(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3978EF),
                    ),
                  ),
                ),
              ),
              Container(
                width: Get.width,
                height: Get.height * 0.25,
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: GoogleMap(
                  mapType: MapType.terrain,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  initialCameraPosition: const CameraPosition(
                    zoom: 15,
                    target: LatLng(-7.8032485, 110.3336448),
                  ),
                  onTap: (argument) => controller.onMapTap(argument),
                  markers: controller.marker.value != null
                      ? <Marker>{controller.marker.value!}
                      : {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: LugoButton(
                    textButton: "Simpan Koordinat",
                    textColor: Colors.white,
                    textSize: 12,
                    width: Get.width * 0.45,
                    height: Get.height * 0.07,
                    color: const Color(0xFF3978EF),
                    onTap: () {}),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  autofocus: false,
                  controller: controller.edtPassword,
                  obscureText: controller.showPassword.value,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF95A1AC),
                  ),
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF95A1AC),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xFF4B39EF),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xFF1D2428),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.red),
                      ),
                      contentPadding: const EdgeInsets.all(24),
                      suffixIcon: GestureDetector(
                        onTap: () => controller.showPassword.value
                            ? controller.showPassword(false)
                            : controller.showPassword(true),
                        child: Icon(
                          controller.showPassword.value
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          color: const Color(0xFF95A1AC),
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: TextFormField(
                  autofocus: false,
                  controller: controller.edtConfirmPassword,
                  obscureText: controller.showConfirmPassword.value,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF95A1AC),
                  ),
                  decoration: InputDecoration(
                      labelText: 'Konfirmasi Password',
                      labelStyle: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF95A1AC),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFF4B39EF))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: const BorderSide(
                              width: 1, color: Color(0xFF1D2428))),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.red)),
                      contentPadding: const EdgeInsets.all(24),
                      suffixIcon: GestureDetector(
                        onTap: () => controller.showConfirmPassword.value
                            ? controller.showConfirmPassword(false)
                            : controller.showConfirmPassword(true),
                        child: Icon(
                            controller.showConfirmPassword.value
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: const Color(0xFF95A1AC)),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: LugoButton(
                    textButton: "Simpan Profile",
                    textColor: Colors.white,
                    textSize: 12,
                    width: Get.width * 0.45,
                    height: Get.height * 0.07,
                    color: const Color(0xFF3978EF),
                    onTap: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}
