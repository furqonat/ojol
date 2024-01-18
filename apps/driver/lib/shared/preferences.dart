import 'package:shared_preferences/shared_preferences.dart';

const authStatus = 'authStatus';
const authState = 'authState';
const referal = 'referal';
const patnerType = 'patnerType';
const currentPage = 'currentPage';

class LocalStorage {
  static late final SharedPreferences instance;
  static bool _init = false;
  static Future init() async {
    if (_init) return;
    instance = await SharedPreferences.getInstance();
    _init = true;
    return instance;
  }
}

class Preferences {
  final SharedPreferences preferences;

  Preferences(this.preferences);

  String getReferal() {
    return preferences.getString(referal) ?? '';
  }

  void setReferal(String ref) {
    preferences.setString(referal, ref);
  }

  bool getAuthstatus() {
    return preferences.getBool(authStatus) ?? false;
  }

  void setAuthStatus(bool status) {
    preferences.setBool(authStatus, status);
  }

  String getPatnerType() {
    return preferences.getString(patnerType) ?? '';
  }

  void setPatnerType(String type) {
    preferences.setString(patnerType, type);
  }

  String getCurrentPage() {
    final page = preferences.getString(currentPage);
    return page ?? '/start';
  }

  void setCurrentPage(String page) {
    preferences.setString(currentPage, page);
  }
}
