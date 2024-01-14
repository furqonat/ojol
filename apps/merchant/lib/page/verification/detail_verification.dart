import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/shared/custom_widget/lugo_btn.dart';

import 'controller.dart';

Widget detailVerification(
  BuildContext context,
  VerificationController controller,
) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: TextFormField(
          autofocus: false,
          controller: controller.fullName,
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
              borderSide: const BorderSide(width: 1, color: Colors.grey),
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
          controller: controller.shopName,
          style: GoogleFonts.readexPro(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF95A1AC),
          ),
          decoration: InputDecoration(
            labelText: 'Nama Toko',
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
              borderSide: const BorderSide(width: 1, color: Colors.grey),
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
          enabled: false,
          autofocus: false,
          controller: controller.address,
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
              borderSide: const BorderSide(width: 1, color: Colors.grey),
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
        child: ElevatedButton(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.place,
              ),
              Text("Gunakan GPS")
            ],
          ),
          onPressed: () {
            controller.pickAddress();
          },
        ),
      ),
      GestureDetector(
        onTap: () {
          controller.handleCaptureIdCardImage();
        },
        child: Container(
          width: Get.width,
          height: Get.height * 0.25,
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: controller.idCardImage.value.isEmpty
              ? Text(
                  'Upload KTP',
                  style: GoogleFonts.readexPro(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3978EF),
                  ),
                )
              : Image.network(
                  controller.idCardImage.value,
                ),
        ),
      ),
      GestureDetector(
        onTap: () {
          controller.handlePickShopImage1();
        },
        child: Container(
          width: Get.width,
          height: Get.height * 0.25,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: controller.shopImages1.value.isEmpty
              ? Text(
                  'Upload Restoran 1',
                  style: GoogleFonts.readexPro(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3978EF),
                  ),
                )
              : Image.network(
                  controller.shopImages1.value,
                ),
        ),
      ),
      GestureDetector(
        onTap: () {
          controller.handlePickShopImage2();
        },
        child: Container(
          width: Get.width,
          height: Get.height * 0.25,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: controller.shopImages2.value.isEmpty
              ? Text(
                  'Upload Restoran 2',
                  style: GoogleFonts.readexPro(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3978EF),
                  ),
                )
              : Image.network(
                  controller.shopImages2.value,
                ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: LugoButton(
          textButton: "Daftar Sekarang",
          textColor: Colors.white,
          textSize: 12,
          width: Get.width * 0.45,
          height: Get.height * 0.07,
          color: const Color(0xFF3978EF),
          onTap: () {
            controller.handleSaveDetail();
          },
        ),
      )
    ],
  );
}
