import 'package:get/get.dart';
import 'package:lugo_marchant/page/form_register/api_form.dart';
import 'package:lugo_marchant/page/form_register/controller_form.dart';

class BindingForm extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControllerForm>(() => ControllerForm(api: ApiForm()));
  }
}
