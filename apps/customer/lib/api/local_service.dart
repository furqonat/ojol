import 'package:get_storage/get_storage.dart';

const String CACHE_USER = 'user';
const String CACHE_TOKEN = 'token';
const String CHECK_LOGIN = "loginState";

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


  Future removeStorageForLogout() async {
    await local.remove(CACHE_USER);
    await local.remove(CACHE_TOKEN);
    await local.remove(CHECK_LOGIN);
  }

}