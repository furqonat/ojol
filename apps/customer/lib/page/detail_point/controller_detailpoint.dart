import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/detail_point/api_detailpoint.dart';

class ControllerDetailPoint extends GetxController{
  final ApiDetailPoint api;
  ControllerDetailPoint({required this.api});

  confirmDiaoog(BuildContext context){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
        title: Text(
          "Tukar poin?",
          style: GoogleFonts.readexPro(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Permintaan anda sudah di proses ditunggu ya hadiahnya, kami akan segera menghubungi anda!",
          style: GoogleFonts.readexPro(
            fontSize: 12,
            color: Colors.black87,
          ),
        ),
        actions: [
          OutlinedButton(
              onPressed: (){
                Get.back();
                Get.back();
              },
              child: Text(
                "Kembali",
                style: GoogleFonts.readexPro(
                  fontSize: 12,
                ),
              ))
        ],
      ),
    );
  }
}