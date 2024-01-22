import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/food_pay/api_foodpay.dart';
import '../../response/cart.dart';

enum Status { idle, loading, success, failed }

class ControllerFoodPay extends GetxController {
  final ApiFoodPay api;
  ControllerFoodPay({required this.api});

  var loading = Status.idle.obs;

  var categoryTypeList = [
    "Pembayaran",
    "Cash",
    "Dana",
  ].obs;

  var categoryType = "Pembayaran".obs;

  var orderPrice = 0.obs;

  final FirebaseAuth firebase = FirebaseAuth.instance;

  RxList<Cart> carts = <Cart>[].obs;
  List<Map<String, dynamic>> listQuantity = <Map<String, dynamic>>[];

  getCartMethod() async {
    try {
      loading(Status.loading);
      var token = await firebase.currentUser?.getIdToken();
      carts.clear();
      orderPrice(0);
      var r = await api.getCart(token: token!);
      if (r["total"] != 0) {
        var items = r["data"]["cart_item"];
        carts(RxList<Cart>.from(items.map((e) => Cart.fromJson(e))));
        listQuantity = List.generate(carts.length, (i) {
          return {'quantity': carts[i].quantity.obs};
        });
        for (var j = 0; j < carts.length; j++) {
          int price = carts[j].product!.price!;
          int quantity = listQuantity[j]['quantity'].value;
          orderPrice.value += quantity * price;
        }
        loading(Status.success);
      } else {
        Get.back();
        loading(Status.failed);
      }
    } catch (e, stackTrace) {
      loading(Status.failed);
      log('$e');
      log('$stackTrace');
    }
  }

  updateCartMethod(String productId, int quantity) async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      if (productId.isNotEmpty) {
        var r = await api.updateCart(
            id_product: productId, quantity: quantity, token: token!);
        if (r["message"] == "OK") {
          getCartMethod();
        } else {
          Fluttertoast.showToast(msg: "Anda gagal merubah daftar belanja anda");
        }
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
  }

  @override
  void onInit() {
    getCartMethod();
    super.onInit();
  }
}
