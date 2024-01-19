import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/shared/utils.dart';
import '../../response/product.dart';
import 'api_menu.dart';

enum Status { idle, loading, success, failed }

class ControllerFoodMenu extends GetxController {
  final ApiFoodMenu api;
  ControllerFoodMenu({required this.api});

  var loading = Status.idle.obs;
  final firebase = FirebaseAuth.instance;

  RxList<Product> product = <Product>[].obs;
  List<Map<String, dynamic>> favoriteStatus = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> listQuantity = <Map<String, dynamic>>[];

  var total = 0.obs;

  var listImg = [
    'assets/images/2023-05-12_(1).jpg',
    'assets/images/2023-05-12_(2).jpg'
  ];

  getProductsMethod() async {
    try {
      loading(Status.loading);
      product.clear();
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.getProducts(token: token!);
      if (r["data"] != null) {
        var list = r["data"];
        product(RxList<Product>.from(list.map((e) => Product.fromJson(e))));
        listQuantity = List.generate(product.length, (i) {
          return {'quantity': 0.obs};
        });
        for (var i = 0; i < product.length; i++) {
          var status = product[i]
              .favorites!
              .where((it) => it.customerId == firebase.currentUser?.uid)
              .toList()
              .isNotEmpty;
          favoriteStatus.add({"status": status.obs});
        }
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

  postLikeProductMethod(String Id_product, int index) async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.postLikeProduct(id_product: Id_product, token: token!);
      if (r["message"] == "OK") {
        if (favoriteStatus[index]['status'].value == true) {
          favoriteStatus[index]['status'].value = false;
        } else {
          favoriteStatus[index]['status'].value = true;
        }
      } else {
        Fluttertoast.showToast(msg: 'Ada yang salah');
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
  }

  cartMethod(String id_product, int quantity, int price) async {
    try {
      var firebaseToken = await firebase.currentUser?.getIdToken();
      if (id_product.isNotEmpty && quantity != 0) {
        var r = await api.cart(
            id_product: id_product, quantity: quantity, token: firebaseToken!);
        if (r['message'] == "OK") {
          total.value = total.value + (price * quantity);
        } else {
          Fluttertoast.showToast(msg: "Product tidak dapat di tambahkan");
        }
      } else {
        Fluttertoast.showToast(msg: "Anda belum memasukan jumlah pesanan anda");
      }
    } catch (e, stackTrace) {
      Fluttertoast.showToast(msg: "Ada yang salah");
      log('$e');
      log('$stackTrace');
    }
  }

  detailProduct(BuildContext context, String imageUrl, String productName,
      int price, String description, bool status) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SizedBox(
        width: Get.width,
        height: Get.height * 0.75,
        child: Column(
          children: <Widget>[
            Container(
              height: 5,
              width: Get.width * 0.3,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: Get.width,
                  height: Get.height * 0.3,
                  imageUrl: imageUrl,
                  errorWidget: (context, url, error) => Image(
                      width: Get.width,
                      height: Get.height * 0.3,
                      fit: BoxFit.cover,
                      image: const AssetImage('assets/images/sample_food.png')),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                productName,
                style: GoogleFonts.readexPro(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: Text(
                convertToIdr(price, 0),
                style: GoogleFonts.readexPro(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                description,
                style: GoogleFonts.readexPro(
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: Card(
                    color: status
                        ? Colors.pink.withOpacity(0.7)
                        : Color(0xFF3978EF).withOpacity(0.7),
                    child: Icon(Icons.favorite_border_rounded,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    getProductsMethod();
    super.onInit();
  }
}
