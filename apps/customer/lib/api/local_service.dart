import 'package:get_storage/get_storage.dart';

const String cacheUser = 'user';
const String cacheToken = 'token';
const String cacheDeviceToken = 'token_device';
const String cacheLogin = "loginState";
const String trxId = "transaction_id";
const String requestType = "request_type";
const String bindingDana = "binding_dana";
const String price = "price";

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

  //set get token device
  Future setTokenDevice({String? tokenDevice}) async {
    tokenDevice ??= "";
    await local.write(cacheDeviceToken, tokenDevice);
  }

  Future<String?> getTokenDevice() async {
    return local.read(cacheDeviceToken);
  }

  //set get status login
  Future setIsLogin({bool? isLogin}) async {
    isLogin ??= false;
    await local.write(cacheLogin, isLogin);
  }

  Future<bool?> getLoginStatus() async {
    return local.read(cacheLogin);
  }

  //set get transaction_id
  Future setTransactionId({String? transaction}) async {
    transaction ??= "";
    await local.write(trxId, transaction);
  }

  Future<String?> getTransactionId() async {
    return local.read(trxId);
  }

  //set get jenis layanan
  Future setRequestType({String? type}) async {
    type ??= "";
    await local.write(requestType, type);
  }

  Future<String?> getRequestType() async {
    return local.read(requestType);
  }

  //set get harga
  Future setPrice({int? prices}) async {
    prices ??= 0;
    await local.write(price, prices);
  }

  Future<int?> getPrice() async {
    return local.read(price);
  }

  Future orderFinish() async {
    await local.remove(trxId);
    await local.remove(requestType);
    await local.remove(price);
  }

  //set get binding dana
  Future setIsBinding({bool? isBinding}) async {
    isBinding ??= false;
    await local.write(bindingDana, isBinding);
  }

  Future<bool?> getIsBinding() async {
    return local.read(bindingDana);
  }

  Future removeStorageForLogout() async {
    await local.remove(cacheUser);
    await local.remove(cacheToken);
    await local.remove(cacheLogin);
    await local.remove(trxId);
    await local.remove(requestType);
    await local.remove(bindingDana);
    await local.remove(price);
  }
}
