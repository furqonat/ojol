import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_driver/response/driver.dart';
import 'package:lugo_driver/route/route_name.dart';
import 'package:lugo_driver/shared/preferences.dart';
import 'package:lugo_driver/shared/query_builder.dart';
import 'package:lugo_driver/shared/validation.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
  final alreadyLink = false.obs;
  final phone = TextEditingController();
  final smsCode = TextEditingController();

  final _fbAuth = FirebaseAuth.instance;

  handleGetDriver() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final currentPhone = _fbAuth.currentUser?.phoneNumber;
    if (currentPhone != null) {
      alreadyLink.value = true;
      phone.value = TextEditingValue(text: currentPhone);
    }
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
        showModalBottomSheet(
          context: Get.context!,
          isDismissible: false,
          constraints: BoxConstraints.expand(
            width: Get.width,
            height: Get.height,
          ),
          builder: (context) => Column(
            children: [
              Text(
                "PIN OTP",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  "Kode OTP sudah kami kirimkan menuju nomor ${phone.text}\nJangan sebarkan kode ini kepada siapapun.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
                ),
              ),
              PinCodeTextField(
                length: 6,
                autoFocus: false,
                hintCharacter: '*',
                appContext: context,
                enableActiveFill: false,
                keyboardType: TextInputType.number,
                controller: smsCode,
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
              const Spacer(),
              ElevatedButton(
                onPressed: () {
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
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    fixedSize: Size(Get.width * 0.5, Get.height * 0.07),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    backgroundColor: const Color(0xFF3978EF)),
                child: Text(
                  "Lanhjutkan",
                  style: GoogleFonts.readexPro(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          ),
        );
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
      _handleMovePage();
    });
  }

  _handleMovePage() {
    final details = driver.value.details;
    if (details == null) {
      preferences.setAlreadyJoin(false);
      Get.offAllNamed(Routes.joinLugo);
      return;
    }
    preferences.setAlreadyJoin(true);
    Get.offAllNamed(Routes.main);
  }

  @override
  void onInit() {
    handleGetDriver();
    super.onInit();
  }
}
