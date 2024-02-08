import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/custom_widget/lugo_button.dart';
import 'controller_editprofile.dart';

class PageEditProfile extends GetView<ControllerEditProfile>{
  const PageEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Column(
                children: <Widget>[
                  Text(
                    "${controller.firebase.currentUser?.displayName}",
                    style: GoogleFonts.readexPro(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    "${controller.firebase.currentUser?.email}",
                    style: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                  Text(
                    "${controller.firebase.currentUser?.phoneNumber}",
                    style: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.w300
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Divider(
                      height: 1,
                      thickness: 1,
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: controller.edtAddress,
                    style: GoogleFonts.poppins(
                        fontSize: 12
                    ),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(CupertinoIcons.map_pin, color: Colors.grey),
                        labelText: "Alamat",
                        labelStyle: GoogleFonts.poppins(
                            fontSize: 12
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 1
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Saya terdaftar sebagai",
                        style: GoogleFonts.poppins(
                            fontSize: 12
                        ),
                      ),
                      const SizedBox(width: 20),
                      Wrap(
                        spacing: 5.0,
                        children: [
                          ...controller.selection.map((e) {
                            return ChoiceChip(
                              label: Text(e),
                              selected:
                              e == controller.selectChip.value,
                              onSelected: controller.handleSelectedChip,
                            );
                          })
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog.adaptive(
                        content: Text(
                          'Ingin ambil gambar dari mana?',
                          style: GoogleFonts.readexPro(fontSize: 12),
                        ),
                        actions: [
                          OutlinedButton(
                              onPressed: () {
                                controller.getKTPFromFile();
                                Get.back();
                              },
                              child: Text(
                                'Galeri',
                                style: GoogleFonts.readexPro(fontSize: 12),
                              )),
                          OutlinedButton(
                              onPressed: () {
                                controller.getKTPFromCamera();
                                Get.back();
                              },
                              child: Text(
                                'Kamera',
                                style: GoogleFonts.readexPro(fontSize: 12),
                              )),
                        ],
                      ),
                    ),
                    child: controller.viewKTP.value.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                          width: Get.width,
                          height: Get.height * 0.25,
                          fit: BoxFit.cover,
                          File(controller.viewKTP.value)),
                    )
                        : Container(
                      width: Get.width,
                      height: Get.height * 0.25,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12)),
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
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog.adaptive(
                        content: Text(
                          'Ingin ambil gambar dari mana?',
                          style: GoogleFonts.readexPro(fontSize: 12),
                        ),
                        actions: [
                          OutlinedButton(
                              onPressed: () {
                                controller.getSIMFromFile();
                                Get.back();
                              },
                              child: Text(
                                'Galeri',
                                style: GoogleFonts.readexPro(fontSize: 12),
                              )),
                          OutlinedButton(
                              onPressed: () {
                                controller.getSIMFromCamera();
                                Get.back();
                              },
                              child: Text(
                                'Kamera',
                                style: GoogleFonts.readexPro(fontSize: 12),
                              )),
                        ],
                      ),
                    ),
                    child: controller.viewSIM.value.isEmpty
                        ? Container(
                      width: Get.width,
                      height: Get.height * 0.25,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12)),
                      alignment: Alignment.center,
                      child: Text(
                        'Upload SIM',
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3978EF),
                        ),
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(controller.viewSIM.value),
                        width: Get.width,
                        height: Get.height * 0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog.adaptive(
                        content: Text(
                          'Ingin ambil gambar dari mana?',
                          style: GoogleFonts.readexPro(fontSize: 12),
                        ),
                        actions: [
                          OutlinedButton(
                              onPressed: () {
                                controller.getKendaraanFromFile();
                                Get.back();
                              },
                              child: Text(
                                'Galeri',
                                style: GoogleFonts.readexPro(fontSize: 12),
                              )),
                          OutlinedButton(
                              onPressed: () {
                                controller.getKendaraanFromCamera();
                                Get.back();
                              },
                              child: Text(
                                'Kamera',
                                style: GoogleFonts.readexPro(fontSize: 12),
                              )),
                        ],
                      ),
                    ),
                    child: controller.viewKendaraan.value.isEmpty
                        ? Container(
                      width: Get.width,
                      height: Get.height * 0.25,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12)),
                      alignment: Alignment.center,
                      child: Text(
                        'Upload Foto Kendaraan',
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3978EF),
                        ),
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(controller.viewKendaraan.value),
                        width: Get.width,
                        height: Get.height * 0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.edtBrand,
                    style: GoogleFonts.poppins(
                        fontSize: 12
                    ),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.brightness_auto_rounded, color: Colors.grey),
                        labelText: "Brand Kendaraan",
                        labelStyle: GoogleFonts.poppins(
                            fontSize: 12
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 1
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.edtYear,
                    style: GoogleFonts.poppins(
                        fontSize: 12
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_month_rounded, color: Colors.grey),
                        labelText: "Tahun Kendaraan",
                        labelStyle: GoogleFonts.poppins(
                            fontSize: 12
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 1
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.edtRegis,
                    style: GoogleFonts.poppins(
                        fontSize: 12
                    ),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.numbers_rounded, color: Colors.grey),
                        labelText: "Plat Kendaraan",
                        labelStyle: GoogleFonts.poppins(
                            fontSize: 12
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 1
                            )
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
              child: LugoButton(
                  textButton: "Simpan",
                  textColor: Colors.white,
                  textSize: 14,
                  width: Get.width,
                  height: Get.height * 0.06,
                  color: const Color(0xFF3978EF),
                  onTap: () => controller.editUser()
              ),
            ),
          ),
        ],
      )),
    );
  }
}
