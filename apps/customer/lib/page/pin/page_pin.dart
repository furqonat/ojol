import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/pin/controller_pin.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PagePin extends GetView<ControllerPin>{
  const PagePin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Masukan Kode Veritifikasi Anda",
          style: GoogleFonts.readexPro(
            fontSize: 14.0,
            color: const Color(0xFF14181B),
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: PinCodeTextField(
                length: 4,
                autoFocus: false,
                hintCharacter: '-',
                appContext: context,
                keyboardType: TextInputType.number,
                enableActiveFill: false,
                controller: controller.edtPin,
                textStyle: GoogleFonts.readexPro(
                  fontSize: 12,
                  color: const Color(0xFF4B39EF),
                ),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                pinTheme: PinTheme(
                  fieldHeight: 60.0,
                  fieldWidth: 60.0,
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
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: Get.width,
              height: Get.height * 0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                      onPressed: (){},
                      child: Text(
                        "Belum MenerimaCode Veritifikasi?",
                        style: GoogleFonts.readexPro(
                          color: const Color(0xFF14181B),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                  ),
                  ElevatedButton(
                      onPressed: ()=> Get.toNamed(Routes.home),
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          fixedSize: Size(Get.width * 0.5, Get.height * 0.07),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          backgroundColor: const Color(0xFF3978EF)
                      ),
                      child: Text(
                        "Confirm & Lanjut",
                        style: GoogleFonts.readexPro(
                            fontSize: 16,
                            color: Colors.white
                        ),
                      )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}