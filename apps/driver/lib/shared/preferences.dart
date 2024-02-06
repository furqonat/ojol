import 'package:shared_preferences/shared_preferences.dart';

const referal = 'referal';
const patnerType = 'patnerType';
const alreadyJoin = 'alreadyJoin';
const alreadySignIn = 'alreadySignIn';
const cacheGetOrder = 'get_order';
const cacheOrderDetail = 'cache_order_detail';
const cahceOrderStep = 'cache_order_step';

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

  bool getOrderStatus() {
    return preferences.getBool(cacheGetOrder) ?? true;
  }
  void setOrderStatus(bool value) {
    preferences.setBool(cacheGetOrder, value);
  }

  dynamic getOrder() {
    return preferences.get(cacheOrderDetail) ?? '';
  }
  void setOrder(dynamic value) {
    preferences.setBool(cacheOrderDetail, value);
  }

  String getOrderStep() {
    return preferences.getString(cahceOrderStep) ?? '';
  }
  void setOrderStep(String value) {
    preferences.setString(cahceOrderStep, value);
  }

  void cleanrepo(){
    preferences.remove(referal);
    preferences.remove(patnerType);
    preferences.remove(alreadyJoin);
    preferences.remove(alreadySignIn);
    preferences.remove(cacheGetOrder);
    preferences.remove(cacheOrderDetail);
    preferences.remove(cahceOrderStep);
  }
}
