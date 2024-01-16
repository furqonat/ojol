import 'package:get_storage/get_storage.dart';

const String CACHE_USER = 'user';
const String CACHE_TOKEN = 'token';
const String CACHE_GET_ORDER = 'get_order';
const String CHECK_LOGIN = "loginState";
const String CHECK_ORDER = "check_order";
const String DOCUMENT_RIDER = "document_rider";

class LocalService{
  final local = GetStorage();

  //set get user
  Future setUser({dynamic user}) async {
    user ??= "";
    await local.write(CACHE_USER, user);
  }
  Future<dynamic> getUser() async {
    return local.read(CACHE_USER);
  }

  //set get token
  Future setToken({String? token}) async {
    token ??= "";
    await local.write(CACHE_TOKEN, token);
  }
  Future<String?> getToken() async {
    return local.read(CACHE_TOKEN);
  }

  //set get status login
  Future setIsLogin({bool? isLogin}) async {
    isLogin ??= false;
    await local.write(CHECK_LOGIN, isLogin);
  }
  Future<bool?> getLoginStatus() async {
    return local.read(CHECK_LOGIN);
  }

  //set get status order
  Future setOrderStatus({bool? statusOrder}) async {
    statusOrder ??= true;
    await local.write(CACHE_GET_ORDER, statusOrder);
  }
  Future<bool?> getOrderStatus() async {
    return local.read(CACHE_GET_ORDER);
  }

  //set get order type
  Future setOrderType({String? orderType}) async {
    orderType ??= "";
    await local.write(CHECK_ORDER, orderType);
  }
  Future<String?> getOrderType() async {
    return local.read(CHECK_ORDER);
  }

  //set get document rider
  Future setDocument({String? doc}) async {
    doc ??= "";
    await local.write(DOCUMENT_RIDER, doc);
  }
  Future<String?> getDocument() async {
    return local.read(DOCUMENT_RIDER);
  }

  Future removeStorageForLogout() async {
    await local.remove(CACHE_USER);
    await local.remove(CACHE_TOKEN);
    await local.remove(CHECK_LOGIN);
    await local.remove(CACHE_GET_ORDER);
    await local.remove(CHECK_ORDER);
    await local.remove(DOCUMENT_RIDER);
  }

}