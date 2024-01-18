import 'package:get_storage/get_storage.dart';

const authStatus = 'authStatus';
const authState = 'authState';
const referal = 'referal';
const patnerType = 'patnerType';
const currentPage = 'currentPage';

class Preferences {
  final GetStorage preferences;

  Preferences(this.preferences);

  String getReferal() {
    return preferences.read(referal) ?? '';
  }

  void setReferal(String ref) {
    preferences.write(referal, ref);
  }

  bool getAuthstatus() {
    return preferences.read(authStatus) ?? false;
  }

  void setAuthStatus(bool status) {
    preferences.write(authStatus, status);
  }

  String getPatnerType() {
    return preferences.read(patnerType) ?? '';
  }

  void setPatnerType(String type) {
    preferences.write(patnerType, type);
  }

  String getCurrentPage() {
    return preferences.read(currentPage) ?? '/start';
  }

  void setCurrentPage(String page) {
    preferences.write(currentPage, page);
  }
}
