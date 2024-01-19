import 'package:shared_preferences/shared_preferences.dart';

const referal = 'referal';
const patnerType = 'patnerType';
const alreadyJoin = 'alreadyJoin';
const alreadySignIn = 'alreadySignIn';

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

  String getPatnerType() {
    return preferences.getString(patnerType) ?? '';
  }

  void setPatnerType(String type) {
    preferences.setString(patnerType, type);
  }

  bool getAlreadyJoin() {
    return preferences.getBool(alreadyJoin) ?? false;
  }

  void setAlreadyJoin(bool value) {
    preferences.setBool(alreadyJoin, value);
  }

  bool getAlreadySignIn() {
    return preferences.getBool(alreadySignIn) ?? false;
  }

  void setAlreadySignIn(bool value) {
    preferences.setBool(alreadySignIn, value);
  }
}
