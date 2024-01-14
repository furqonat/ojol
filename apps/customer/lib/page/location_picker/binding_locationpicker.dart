import 'package:get/get.dart';
import 'package:lugo_customer/page/location_picker/api_locationpicker.dart';
import 'package:lugo_customer/page/location_picker/controller_locationpicker.dart';

class BindingLocationPicker implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ControllerLocationPicker>(() => ControllerLocationPicker(api: ApiLocationPicker()));
  }
}