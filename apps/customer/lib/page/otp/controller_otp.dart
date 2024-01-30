import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/otp/api_otp.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../api/local_service.dart';
import '../../route/route_name.dart';

enum Status { idle, loading, success, failed }

class ControllerOtp extends GetxController {
  final ApiOtp api;
  ControllerOtp({required this.api});

  final formkeyPhone = GlobalKey<FormState>();

  final edtPhone = TextEditingController();
  final edtOTP = TextEditingController();

  final loading = Status.idle.obs;

  final _fbAuth = FirebaseAuth.instance;
  final loadingPhoneVerification = false.obs;

  //Verify no hp
  firebasePhoneVerification(BuildContext context) async {
    try {
      await _fbAuth.verifyPhoneNumber(
        phoneNumber: '+62${edtPhone.text}',
        verificationFailed: (error) {},
        codeAutoRetrievalTimeout: (verificationId) {},
        verificationCompleted: (phoneAuthCredential) {},
        codeSent: (verificationId, forceResendingToken) async {
          showModalBottomSheet(
            context: context,
            isDismissible: false,
            constraints:
                BoxConstraints.expand(width: Get.width, height: Get.height),
            builder: (context) => Column(
              children: [
                Text(
                  "PIN OTP",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Kode OTP sudah kami kirimkan menuju nomor ${edtPhone.text}\nJangan sebarkan kode ini kepada siapapun.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Colors.black54),
                  ),
                ),
                PinCodeTextField(
                  length: 6,
                  autoFocus: false,
                  hintCharacter: '-',
                  appContext: context,
                  enableActiveFill: false,
                  keyboardType: TextInputType.number,
                  controller: edtOTP,
                  textStyle: GoogleFonts.readexPro(
                    fontSize: 12,
                    color: const Color(0xFF4B39EF),
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  pinTheme: PinTheme(
                    fieldHeight: 50.0,
                    fieldWidth: 50.0,
                    borderWidth: 2.0,
                    borderRadius: BorderRadius.circular(12.0),
                    shape: PinCodeFieldShape.box,
                    activeColor: const Color(0xFF4B39EF),
                    inactiveColor: const Color(0xFFF1F4F8),
                    selectedColor: const Color(0xFF95A1AC),
                    activeFillColor: const Color(0xFF4B39EF),
                    inactiveFillColor: const Color(0xFFF1F4F8),
                    selectedFillColor: const Color(0xFF95A1AC),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final credential = PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: edtOTP.text);
                      _fbAuth.currentUser
                          ?.updatePhoneNumber(credential)
                          .then((value) async {
                        var useToken = await _fbAuth.currentUser?.getIdToken();
                        sendToken(context, useToken!);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        fixedSize: Size(Get.width * 0.5, Get.height * 0.07),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        backgroundColor: const Color(0xFF3978EF)),
                    child: Text(
                      "Lanhjutkan",
                      style: GoogleFonts.readexPro(
                          fontSize: 16, color: Colors.white),
                    ))
              ],
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    }
  }

  //Hit api
  sendToken(BuildContext context, String token) async {
    try {
      loading.value = Status.loading;
      var r = await api.sendToken(sample: '', token: token);
      if (r["message"] == "OK") {
        getFirebasetoken("");
        await LocalService().setIsLogin(isLogin: true);
        Get.offAllNamed(Routes.home);
        loading.value = Status.success;
      } else {
        loading.value = Status.failed;
        log('save token gagal');
      }
    } catch (e, stackTrace) {
      loading.value = Status.failed;
      log(e.toString());
      log(stackTrace.toString());
    }
  }

  // get Firebase token
  getFirebasetoken(String token) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.currentUser?.getIdToken(true);
      if (userCredential != null) {}
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-custom-token":
          log("The supplied token is not a Firebase custom auth token.");
          break;
        case "custom-token-mismatch":
          log("The supplied token is for a different Firebase project.");
          break;
        default:
          log("Unkown error.");
      }
    }
  }

  @override
  void dispose() {
    edtPhone.dispose();
    super.dispose();
  }
}
