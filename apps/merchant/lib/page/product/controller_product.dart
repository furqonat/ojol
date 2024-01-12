import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/product/api_product.dart';

import '../../response/product.dart';

enum Status { idle, loading, success, failed }

class ControllerProduct extends GetxController {
  final ApiProduct api;
  ControllerProduct({required this.api});

  var loading = Status.idle.obs;

  var category = "Kategori".obs;

  var categoryList = [
    "Kategori",
    "Opsi 1",
    "Opsi 2",
    "Opsi 3",
    "Opsi 5",
  ].obs;

  final firebase = FirebaseAuth.instance;

  final product = <Product>[].obs;

  getProducts() async {
    try {
      loading(Status.loading);
      product.clear();
      var token = await firebase.currentUser?.getIdToken();
      var userId = firebase.currentUser?.uid;
      var r = await api.getProducts(
        token: token!,
        merchantId: userId!,
        filter: category.value == "Kategori" ? null : category.value,
      );
      if (r["data"] != null) {
        var list = r["data"]! as List<dynamic>;
        product(RxList<Product>.from(list.map((e) => Product.fromJson(e))));
        loading(Status.success);
      } else {
        Fluttertoast.showToast(msg: 'Ada yang salah');
        loading(Status.failed);
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
      loading(Status.failed);
    }
  }

  filterBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        width: Get.width,
        height: Get.height * 0.25,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  )),
              child: DropdownButton<String>(
                elevation: 2,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF95A1AC),
                  size: 24,
                ),
                value: category.value,
                borderRadius: BorderRadius.circular(8),
                underline: const SizedBox(),
                isExpanded: true,
                items: categoryList.map((element) {
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
                onChanged: (String? value) => category(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(Get.width, Get.height * 0.06),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: const Color(0xFF3978EF)),
                  child: Text(
                    "Lanjutkan",
                    style: GoogleFonts.readexPro(
                        fontSize: 16, color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }
}
