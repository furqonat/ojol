import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/edit_product/controller_editproduct.dart';

import '../../shared/custom_widget/lugo_btn.dart';

class PageEditProduct extends GetView<ControllerEditProduct> {
  const PageEditProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Produk",
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog.adaptive(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    content: Text(
                      'Ambil gambar produk dari?',
                      style: GoogleFonts.readexPro(
                          fontSize: 12, color: Colors.black),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: controller.image.value != ''
                        ? Image.network(
                            controller.image.value,
                            width: Get.width,
                            height: Get.height * 0.3,
                            fit: BoxFit.cover,
                            errorBuilder: (context, url, error) => Image(
                              width: Get.width,
                              height: Get.height * 0.3,
                              fit: BoxFit.cover,
                              image: const AssetImage(
                                  'assets/images/sample_food.png'),
                            ),
                          )
                        : Image(
                            width: Get.width,
                            height: Get.height * 0.3,
                            fit: BoxFit.cover,
                            image: const AssetImage(
                                'assets/images/sample_food.png'),
                          ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  autofocus: false,
                  controller: controller.name,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
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
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF4B39EF))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
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
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  autofocus: false,
                  controller: controller.description,
                  maxLines: 5,
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    labelText: 'keterangan',
                    labelStyle: GoogleFonts.readexPro(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF4B39EF))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
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
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width * 0.72,
                      height: Get.height * 0.075,
                      child: TextFormField(
                        autofocus: false,
                        maxLines: 1,
                        controller: controller.price,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.readexPro(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
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
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFF4B39EF))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFF1D2428))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.red)),
                          contentPadding: const EdgeInsets.all(24),
                        ),
                      ),
                    ),
                    Switch(
                      value: controller.status.value,
                      onChanged: (value) => controller.status(value),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: LugoButton(
                    textButton: "Simpan Perubahan",
                    textColor: Colors.white,
                    textSize: 12,
                    width: Get.width * 0.5,
                    height: Get.height * 0.065,
                    color: const Color(0xFF3978EF),
                    onTap: () => controller.handleSaveEditProduct(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
