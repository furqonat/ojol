import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_driver/shared/custom_widget/lugo_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:validatorless/validatorless.dart';

import 'controller_phone_verification.dart';

class PagePhoneVerification extends GetView<ControllerPhoneVerification> {
  const PagePhoneVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: TextFormField(
              autofocus: false,
              keyboardType: TextInputType.phone,
              controller: controller.phone,
              style: GoogleFonts.readexPro(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF95A1AC),
              ),
              decoration: InputDecoration(
                labelText: 'Nomor Ponsel',
                labelStyle: GoogleFonts.readexPro(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF95A1AC),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0xFF4B39EF),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0xFF1D2428),
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
                contentPadding: const EdgeInsets.all(24),
              ),
              validator:
                  Validatorless.required("Nomor ponsel tidak boleh kosong"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: LugoButton(
              textButton: "Lanjutkan",
              textColor: Colors.white,
              textSize: 20,
              width: 90,
              height: 80,
              color: const Color(0xFF4B39EF),
              onTap: () {
                bottomSheet(context);
              },
            ),
          )
        ],
      ),
    );
  }

  bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
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
              "Kode OTP sudah kami kirimkan menuju nomor ${controller.phone.text}\nJangan sebarkan kode ini kepada siapapun.",
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
            controller: controller.smsCode,
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
              controller.handlePhoneVerification();
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
  }
}
