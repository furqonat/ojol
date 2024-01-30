import 'package:get_storage/get_storage.dart';
import 'package:lugo_customer/route/route_name.dart';

const inVerification = 'inVerification';
const verifcationPage = 'verifcationPage';

class LocalStorage {
  final GetStorage storage;

  LocalStorage({required this.storage});

  bool isInVerification() {
    return storage.read(inVerification) ?? false;
  }

  void setInVerification(bool value) {
    storage.write(inVerification, value);
  }

  void setVerifcationPage(String value) {
    storage.write(verifcationPage, value);
  }

  String getVerifcationPage() {
    return storage.read(verifcationPage) ?? Routes.auth;
  }
}
