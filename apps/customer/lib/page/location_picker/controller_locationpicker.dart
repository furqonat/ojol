import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/location_picker/api_locationpicker.dart';

class ControllerLocationPicker extends GetxController {
  final ApiLocationPicker api;
  ControllerLocationPicker({required this.api});

  var edtPickUp = TextEditingController();
  var edtDropOff = TextEditingController();
  var edtPackage = TextEditingController();
  var edtDiscount = TextEditingController();

  var requestType = "".obs;

  var payTypeList = [
    "Pembayaran",
    "Dana",
    "Cash",
  ].obs;

  var payType = "Pembayaran".obs;

  var firstStep = true.obs;
  var secondStep = false.obs;
  var deliveryStep = false.obs;

  @override
  void onInit() {
    requestType(Get.arguments["request_type"]);
    firstStep(true);
    secondStep(false);
    deliveryStep(false);
    super.onInit();
  }

  argumentChecker() => Get.arguments['request_type'];

  @override
  void dispose() {
    edtPickUp.dispose();
    edtDropOff.dispose();
    edtPackage.dispose();
    edtDiscount.dispose();
    super.dispose();
  }
}
