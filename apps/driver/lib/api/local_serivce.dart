import 'package:get_storage/get_storage.dart';

const String cacheUser = 'user';
const String cacheToken = 'token';
const String cacheGetOrder = 'get_order';
const String checkLogin = "loginState";
const String checkOrder = "check_order";
const String documentRider = "document_rider";

class LocalService {
  final local = GetStorage();

  //set get user
  Future setUser({dynamic user}) async {
    user ??= "";
    await local.write(cacheUser, user);
  }

  Future<dynamic> getUser() async {
    return local.read(cacheUser);
  }

  //set get token
  Future setToken({String? token}) async {
    token ??= "";
    await local.write(cacheToken, token);
  }

  Future<String?> getToken() async {
    return local.read(cacheToken);
  }

  //set get status login
  Future setIsLogin({bool? isLogin}) async {
    isLogin ??= false;
    await local.write(checkLogin, isLogin);
  }

  Future<bool?> getLoginStatus() async {
    return local.read(checkLogin);
  }

  //set get status order
  Future setOrderStatus({bool? statusOrder}) async {
    statusOrder ??= true;
    await local.write(cacheGetOrder, statusOrder);
  }

  Future<bool?> getOrderStatus() async {
    return local.read(cacheGetOrder);
  }

  //set get order type
  Future setOrderType({String? orderType}) async {
    orderType ??= "";
    await local.write(checkOrder, orderType);
  }

  Future<String?> getOrderType() async {
    return local.read(checkOrder);
  }

  //set get document rider
  Future setDocument({String? doc}) async {
    doc ??= "";
    await local.write(documentRider, doc);
  }

  Future<String?> getDocument() async {
    return local.read(documentRider);
  }

  Future removeStorageForLogout() async {
    await local.remove(cacheUser);
    await local.remove(cacheToken);
    await local.remove(checkLogin);
    await local.remove(cacheGetOrder);
    await local.remove(checkOrder);
    await local.remove(documentRider);
  }
}
