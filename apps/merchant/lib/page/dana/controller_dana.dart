import 'package:get/get.dart';
import 'package:lugo_marchant/page/dana/api_dana.dart';

class ControllerDana extends GetxController{
  final ApiDana api;
  ControllerDana({required this.api});

  var orderList = [
    "Hari ini",
    "Minggu ini",
    "Bulan ini",
  ].obs;

  var orderValue = "Hari ini".obs;
}