import 'package:get_storage/get_storage.dart';

const String cacheUser = 'user';
const String cacheToken = 'token';
const String autoBid = 'autoBid';
const String checkLogin = "loginState";
const String checkOrder = "check_order";
const String documentRider = "document_rider";

class LocalService {
  final GetStorage local;

  LocalService(this.local);

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
  Future setAutoBid({bool? statusOrder}) async {
    statusOrder ??= true;
    await local.write(autoBid, statusOrder);
  }

  Future<bool?> getAutoBid() async {
    return local.read(autoBid);
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
    await local.remove(autoBid);
    await local.remove(checkOrder);
    await local.remove(documentRider);
  }
}
