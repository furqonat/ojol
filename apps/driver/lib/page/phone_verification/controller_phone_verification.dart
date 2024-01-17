import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/response/driver.dart';
import 'package:lugo_driver/route/route_name.dart';
import 'package:lugo_driver/shared/preferences.dart';
import 'package:lugo_driver/shared/query_builder.dart';
import 'package:lugo_driver/shared/validation.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/auth_client.dart';

class ControllerPhoneVerification extends GetxController {
  ControllerPhoneVerification({
    required this.authClient,
    required this.accountClient,
    required this.preferences,
  });

  final AuthClient authClient;
  final AccountClient accountClient;
  final Preferences preferences;
  final driver = Driver().obs;

  final phone = TextEditingController();
  final smsCode = TextEditingController();

  final _fbAuth = FirebaseAuth.instance;

  handleGetDriver() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final query = QueryBuilder()
      ..addQuery("id", "true")
      ..addQuery("driver_details", "true");
    final resp = await accountClient.getDriver(
      bearerToken: "Bearer $token",
      queries: query.toMap(),
    );
    driver.value = Driver.fromJson(resp);
  }

  handlePhoneVerification() async {
    final isValidPhone = await validatePhoneNumber(phone.text);
    final phoneNumber = await e164PhoneNumber(phone.text);
    if (!isValidPhone) {
      Fluttertoast.showToast(msg: "Phone number is not valid");
      return;
    }
    _fbAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber.e164,
      verificationCompleted: (credential) {
        final userPhone = _fbAuth.currentUser?.phoneNumber;
        if (userPhone != null && userPhone == phoneNumber.e164) {
          _reAuthUserWithPhoneNumber(credential);
          return;
        } else if (userPhone != null && userPhone != phoneNumber.e164) {
          _linkUserWithPhoneNumber(credential);
          return;
        } else {
          _linkUserWithPhoneNumber(credential);
          return;
        }
      },
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        final credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode.text,
        );
        final userPhone = _fbAuth.currentUser?.phoneNumber;
        if (userPhone != null && userPhone == phoneNumber.e164) {
          _reAuthUserWithPhoneNumber(credential);
          return;
        } else if (userPhone != null && userPhone != phoneNumber.e164) {
          _linkUserWithPhoneNumber(credential);
          return;
        } else {
          _linkUserWithPhoneNumber(credential);
          return;
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: const Duration(seconds: 30),
    );
  }

  _linkUserWithPhoneNumber(PhoneAuthCredential credential) {
    final currentUser = _fbAuth.currentUser;
    currentUser?.linkWithCredential(credential).then((value) {
      _handleMovePage();
    });
  }

  _reAuthUserWithPhoneNumber(PhoneAuthCredential credential) {
    final currentUser = _fbAuth.currentUser;
    currentUser?.reauthenticateWithCredential(credential).then((value) {
      preferences.setAuthStatus(true);
      _handleMovePage();
    });
  }

  _handleMovePage() {
    final details = driver.value.details;
    if (details == null) {
      Get.offAndToNamed(Routes.joinLugo);
      return;
    }
    Get.offAndToNamed(Routes.main);
  }

  @override
  void onInit() {
    handleGetDriver();
    super.onInit();
  }
}
