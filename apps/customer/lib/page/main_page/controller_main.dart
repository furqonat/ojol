import 'package:get/get.dart';
import 'package:lugo_customer/page/main_page/api_main.dart';

class ControllerMain extends GetxController {
  final ApiMain api;
  ControllerMain({required this.api});

  var listImg = [
    'assets/images/2023-05-12_(1).jpg',
    'assets/images/2023-05-05.jpg',
    'assets/images/2023-05-12_(2).jpg'
  ];

  var secondListImg = [
    'assets/images/2023-05-12_(2).jpg',
    'assets/images/2023-05-05.jpg',
    'assets/images/2023-05-12_(1).jpg'
  ];

  @override
  void onInit() {
    super.onInit();
  }
}
