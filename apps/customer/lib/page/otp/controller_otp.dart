import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/otp/api_otp.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:lugo_customer/shared/local_storage.dart';
import 'package:lugo_customer/shared/phone_e16.dart';
import 'package:lugo_customer/shared/widget/button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rest_client/account_client.dart';

enum Status { idle, loading, success, failed }

class ControllerOtp extends GetxController {
  final ApiOtp api;
  final AccountClient accountClient;
  final LocalStorage storage;
  ControllerOtp(
      {required this.api, required this.accountClient, required this.storage});

  final formkeyPhone = GlobalKey<FormState>();

  final edtPhone = TextEditingController();
  final edtOTP = TextEditingController();

  final loading = Status.idle.obs;

  final _fbAuth = FirebaseAuth.instance;
  final loadingPhoneVerification = false.obs;
  final loadingOTP = false.obs;

  Future<String?> handleVerifyPhoneNumber() async {
    loadingPhoneVerification.value = true;
    if (!formkeyPhone.currentState!.validate()) {
      Get.snackbar("Error", "Please enter your phone number");
      loadingPhoneVerification.value = false;
      return null;
    }
    final token = await _fbAuth.currentUser?.getIdToken(true);
    final phone = await phoneE16(edtPhone.text);
    final resp = await accountClient.customerVerifyPhoneNumber(
      bearerToken: "Bearer $token",
      body: Verification(phoneNumber: phone.e164),
    );
    if (resp.message == 'OK') {
      loadingPhoneVerification.value = false;
      return resp.res;
    }
    loadingPhoneVerification.value = false;
    return null;
  }

  void bottomSheetOtp(String verificationId) {
    showModalBottomSheet(
      context: Get.context!,
      isDismissible: false,
      constraints: BoxConstraints.expand(width: Get.width, height: Get.height),
      builder: (context) => Column(
        children: [
          Text(
            "PIN OTP",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              "Kode OTP sudah kami kirimkan menuju nomor ${edtPhone.text}\nJangan sebarkan kode ini kepada siapapun.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
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
          Button(
            onPressed: () async {
              if (loadingOTP.value) return;
              await complateVerification(verificationId);
            },
            child: loadingOTP.value
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : Text(
                    "Selesai",
                    style: GoogleFonts.readexPro(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
          )
        ],
      ),
    );
  }

  complateVerification(String verificationId) async {
    loadingOTP.value = true;
    final token = await _fbAuth.currentUser?.getIdToken();
    final resp = await accountClient.customerFinishVerifyPhoneNumber(
      bearerToken: "Bearer $token",
      id: verificationId,
      body: VerifyPhoneNumber(smsCode: edtOTP.text),
    );
    if (resp.message == 'OK') {
      loadingOTP.value = false;
      storage.setIsSignIn(true);
      Get.offAllNamed(Routes.home);
    } else {
      loadingOTP.value = false;
      Get.snackbar("Error", "Incorrect OTP");
    }
  }

  @override
  void onInit() {
    storage.setVerifcationPage(Routes.otp);
    super.onInit();
  }

  @override
  void dispose() {
    edtPhone.dispose();
    super.dispose();
  }
}
