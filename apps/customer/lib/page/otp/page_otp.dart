import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/otp/controller_otp.dart';
import 'package:validatorless/validatorless.dart';

class PageOtp extends GetView<ControllerOtp>{
  const PageOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: ()=> Get.back(),
            child: Card(
              elevation: 0,
              color: const Color(0xFF3978EF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)
              ),
              child: const Center(
                child: Icon(Icons.chevron_left, size: 24, color: Colors.white),
              ),
            )
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Text(
              "Masukan Nomor Telepon Veritifikasi Anda",
              style: GoogleFonts.readexPro(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF14181B),
              ),
            ),
          ),
          Form(
            key: controller.formkeyPhone,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: TextFormField(
                autofocus: false,
                controller: controller.edtPhone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                    labelStyle: GoogleFonts.readexPro(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xFF95A1AC),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFF4B39EF)
                        )
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Colors.grey
                        )
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xFF1D2428)
                        )
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Colors.red
                        )
                    ),
                    contentPadding: const EdgeInsets.all(24)
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('Ponsel tidak boleh kosong'),
                  Validatorless.regex(RegExp(r'^[1-9][0-9]{8,}$'), 'Ponsel tidak sesuai, cukup gunakan 813xxxxxxxx'),
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: ElevatedButton(
                  onPressed: (){
                    if(controller.formkeyPhone.currentState!.validate()){
                      controller.firebasePhoneVerification(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(Get.width * 0.5, Get.height * 0.07),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      backgroundColor: const Color(0xFF3978EF)
                  ),
                  child: Text(
                    "Masuk",
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        color: Colors.white
                    ),
                  )
              ),
            ),
          )
        ],
      ),
    );
  }
}