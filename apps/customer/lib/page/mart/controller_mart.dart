import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'api_mart.dart';

class ControllerMart extends GetxController{
  final ApiMart api;
  ControllerMart({required this.api});

  var edtSearch = TextEditingController();

  var categoryTypeList = [
    "Kategori",
    "Makanan ringan",
    "Minuman",
    "Buah",
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