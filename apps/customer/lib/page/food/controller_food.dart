import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lugo_customer/page/food/api_food.dart';

class ControllerFood extends GetxController{
  final ApiFood api;
  ControllerFood({required this.api});

  var edtSearch = TextEditingController();

  var categoryTypeList = [
    "Kategori",
    "Makanan berat",
    "Makanan ringan",
    "Minuman",
  ].obs;

  var categoryType = "Kategori".obs;

  var listImg = [
    'assets/images/2023-05-12_(1).jpg',
    'assets/images/2023-05-12_(2).jpg'
  ];

  @override
  void dispose() {
    edtSearch.dispose();
    super.dispose();
  }
}