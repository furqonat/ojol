import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/category/controller_category.dart';

class PageCategory extends GetView<ControllerCategory> {
  const PageCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Produk Manajemen"),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  text: 'Buat Kategori',
                ),
                Tab(
                  text: 'Tambah Jualan',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: <Widget>[
                  createCategory(),
                  createProduct(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createProduct(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: DropdownButton<String>(
            elevation: 2,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF95A1AC),
              size: 24,
            ),
            value: controller.categoryValue.value,
            borderRadius: BorderRadius.circular(8),
            underline: const SizedBox(),
            isExpanded: true,
            items: controller.categoryList.map((element) {
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
            onChanged: (String? value) => controller.categoryValue(value),
          ),
        ),
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog.adaptive(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              content: Text(
                'Ambil gambar produk dari?',
                style: GoogleFonts.readexPro(fontSize: 12, color: Colors.black),
              ),
              actions: [
                OutlinedButton(
                    onPressed: () {
                      controller.getFromCamera();
                      Get.back();
                    },
                    child: Text(
                      'Camera',
                      style: GoogleFonts.readexPro(
                          fontSize: 12, color: Colors.black),
                    )),
                OutlinedButton(
                    onPressed: () {
                      controller.getFromFile();
                      Get.back();
                    },
                    child: Text(
                      'Galeri',
                      style: GoogleFonts.readexPro(
                          fontSize: 12, color: Colors.black),
                    )),
              ],
            ),
          ),
          child: controller.img.value.isEmpty
              ? Container(
                  width: Get.width,
                  height: Get.height * 0.25,
                  margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12)),
                  alignment: Alignment.center,
                  child: Text(
                    'Foto Produk',
                    style: GoogleFonts.readexPro(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                        width: Get.width,
                        height: Get.height * 0.25,
                        fit: BoxFit.cover,
                        File(controller.img.value)),
                  ),
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: TextFormField(
            autofocus: false,
            controller: controller.edtName,
            style: GoogleFonts.readexPro(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF95A1AC),
            ),
            decoration: InputDecoration(
              labelText: 'Nama',
              labelStyle: GoogleFonts.readexPro(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF95A1AC),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF4B39EF))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1, color: Colors.grey)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF1D2428))),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(width: 1, color: Colors.red)),
              contentPadding: const EdgeInsets.all(24),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: TextFormField(
            autofocus: false,
            controller: controller.edtPrice,
            style: GoogleFonts.readexPro(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF95A1AC),
            ),
            decoration: InputDecoration(
              labelText: 'Harga',
              labelStyle: GoogleFonts.readexPro(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF95A1AC),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF4B39EF))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1, color: Colors.grey)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF1D2428))),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(width: 1, color: Colors.red)),
              contentPadding: const EdgeInsets.all(24),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: TextFormField(
            autofocus: false,
            keyboardType: TextInputType.number,
            controller: controller.edtQuantity,
            style: GoogleFonts.readexPro(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF95A1AC),
            ),
            decoration: InputDecoration(
              labelText: 'Jumlah',
              labelStyle: GoogleFonts.readexPro(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF95A1AC),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF4B39EF))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1, color: Colors.grey)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF1D2428))),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(width: 1, color: Colors.red)),
              contentPadding: const EdgeInsets.all(24),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: TextFormField(
            autofocus: false,
            controller: controller.edtDescription,
            style: GoogleFonts.readexPro(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF95A1AC),
            ),
            decoration: InputDecoration(
              labelText: 'Keterangan',
              labelStyle: GoogleFonts.readexPro(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF95A1AC),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF4B39EF))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1, color: Colors.grey)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF1D2428))),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(width: 1, color: Colors.red)),
              contentPadding: const EdgeInsets.all(24),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: TextFormField(
            autofocus: false,
            controller: controller.edtCategoryName,
            style: GoogleFonts.readexPro(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF95A1AC),
            ),
            decoration: InputDecoration(
              labelText: 'Kategori *Opsional',
              labelStyle: GoogleFonts.readexPro(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF95A1AC),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF4B39EF))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1, color: Colors.grey)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF1D2428))),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(width: 1, color: Colors.red)),
              contentPadding: const EdgeInsets.all(24),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ElevatedButton(
              onPressed: () {
                if (controller.categoryValue.value != "Kategori" &&
                    controller.edtCategoryName.text.isNotEmpty) {
                  Fluttertoast.showToast(
                      msg:
                          "Anda tidak dapat membuat produk dengan memasukan lebih dari satu kategori");
                } else if (controller.categoryValue.value != "Kategori" &&
                    controller.edtCategoryName.text.isEmpty) {
                  controller.uploadMenuCurrentCategory();
                } else if (controller.categoryValue.value == "Kategori" &&
                    controller.edtCategoryName.text.isNotEmpty) {
                  controller.uploadMenuNewCategory();
                } else {
                  Fluttertoast.showToast(
                      msg: "Anda tidak memberikan kategori dalam produk anda");
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  fixedSize: Size(Get.width * 0.5, Get.height * 0.065),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: const Color(0xFF3978EF)),
              child: Text(
                "Simpan",
                style: GoogleFonts.readexPro(fontSize: 16, color: Colors.white),
              )),
        ),
      ],
    );
  }

  Widget createCategory() {
    return Column(
      children: <Widget>[
        Text(
          "Buat Kategory",
          textAlign: TextAlign.justify,
          style: GoogleFonts.readexPro(
              fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: TextFormField(
            controller: controller.edtCategory,
            style: GoogleFonts.readexPro(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF95A1AC),
            ),
            decoration: InputDecoration(
              labelText: 'Kategori',
              labelStyle: GoogleFonts.readexPro(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF95A1AC),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF4B39EF))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(width: 1, color: Colors.grey)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide:
                      const BorderSide(width: 1, color: Color(0xFF1D2428))),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(width: 1, color: Colors.red)),
              contentPadding: const EdgeInsets.all(24),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  fixedSize: Size(Get.width * 0.5, Get.height * 0.065),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  backgroundColor: const Color(0xFF3978EF)),
              child: Text(
                "Tambahkan",
                style: GoogleFonts.readexPro(fontSize: 16, color: Colors.white),
              )),
        ),
      ],
    );
  }
}
