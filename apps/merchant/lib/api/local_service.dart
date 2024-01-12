import 'package:get_storage/get_storage.dart';
import 'package:lugo_marchant/page/verification/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String cacheUser = 'user';
const String cacheToken = 'token';
const String loginState = "loginState";
const signUpStatus = "isSignUp";
const inVerification = 'inVerification';
const verificationStep = 'verificationStep';

class LocalService {
  final local = GetStorage();
  final preferences = SharedPreferences.getInstance();

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
  Future setIsLogin({required bool isLogin}) async {
    final prefs = await preferences;
    await prefs.setBool(loginState, isLogin);
  }

  Future<bool> getLoginStatus() async {
    final prefs = await preferences;
    return prefs.getBool(loginState) ?? false;
  }

  Future<void> setInVerification(bool status) async {
    final prefs = await preferences;
    await prefs.setBool(inVerification, status);
  }

  Future<bool> isInVerification() async {
    final prefs = await preferences;
    return prefs.getBool(inVerification) ?? false;
  }

  Future<void> setInVerificationStep(VerificationState state) async {
    final prefs = await preferences;
    await prefs.setString(verificationStep, "$state");
  }

  Future<String> getInVerificationStep() async {
    final prefs = await preferences;
    return prefs.getString(verificationStep) ?? "0";
  }

  Future<bool> isSignup() async {
    return local.read(signUpStatus) ?? false;
  }

  Future<void> setIsSignUp({required bool isSignUp}) async {
    await local.write(signUpStatus, isSignUp);
  }

  Future removeStorageForLogout() async {
    await local.remove(cacheUser);
    await local.remove(cacheToken);
    await local.remove(loginState);
    await local.remove(signUpStatus);
  }
}
