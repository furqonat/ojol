import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_customer/page/delivery_finish/api_delivfinish.dart';

class ControllerDelivFinish extends GetxController {
  final ApiDelivFinish api;
  ControllerDelivFinish({required this.api});

  var imgPreview = ''.obs;
  var price = 0.obs;
  var paymentType = ''.obs;

  final ImagePicker picker = ImagePicker();

  getFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      imgPreview.value = camImage.path;
    }
  }

  getFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      imgPreview.value = fileImage.path;
    }
  }

  @override
  void onInit() {
    price.value = Get.arguments["price"];
    paymentType.value = Get.arguments["payment_type"];
    super.onInit();
  }
}
