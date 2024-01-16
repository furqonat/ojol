import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lugo_driver/route/route_name.dart';
import 'package:lugo_driver/shared/preferences.dart';
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

  final phone = TextEditingController();
  final smsCode = TextEditingController();

  final _fbAuth = FirebaseAuth.instance;

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
        _linkUserWithPhoneNumber(credential);
      },
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        final credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode.text,
        );
        _linkUserWithPhoneNumber(credential);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: const Duration(seconds: 30),
    );
  }

  _linkUserWithPhoneNumber(PhoneAuthCredential credential) {
    final currentUser = _fbAuth.currentUser;
    currentUser?.linkWithCredential(credential).then((value) {
      preferences.setAuthStatus(true);
      Get.offAndToNamed(Routes.main);
    });
  }
}
