import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validatorless/validatorless.dart';
import 'controller_password.dart';

class ForgotPassword extends GetView<ControllerPassword> {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextFormField(
              controller: controller.emailEditText,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: GoogleFonts.readexPro(
                  fontSize: 16,
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
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
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
              validator: Validatorless.multiple(
                [
                  Validatorless.required('Email tidak boleh kosong'),
                  Validatorless.email('Email tidak sesuai')
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                controller.sendEmailResetPassword();
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                fixedSize: Size(Get.width * 0.5, Get.height * 0.07),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                backgroundColor: const Color(0xFF3978EF),
              ),
              child: Text(
                "Kirim Email",
                style: GoogleFonts.readexPro(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
