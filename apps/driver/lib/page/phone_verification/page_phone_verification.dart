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
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                enabled: !controller.alreadyLink.value,
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
                validator: Validatorless.required("Nomor ponsel tidak boleh kosong"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: LugoButton(
                textButton: "Lanjutkan",
                textColor: Colors.white,
                textSize: 20,
                width: Get.width * .5,
                height: 80,
                color: const Color(0xFF4B39EF),
                onTap: () => controller.handlePhoneVerification(),
              ),
            )
          ],
        ),
      ),
    );
  }

}
