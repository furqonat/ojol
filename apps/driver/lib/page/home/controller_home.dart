import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_driver/shared/utils.dart';
import 'api_home.dart';

class ControllerHome extends GetxController{
  final ApiHome api;
  ControllerHome({required this.api});

  var orderSetting = true.obs;
  var accountSetting = true.obs;

  var showBottomSheet = false.obs;
  var showPickUpLocation = true.obs;
  var showDropDownLocation = false.obs;

  orderDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Row(
            children: <Widget>[
              Text(
                "Rider",
                style: GoogleFonts.readexPro(
                  fontSize: 20,
                  color: const Color(0xFF3978EF),
                  fontWeight: FontWeight.bold
                ),
              ),
              const Spacer(),
              const Icon(
                  Icons.directions_bike_rounded,
                  color: Color(0xFF3978EF)
              )
            ],
          ),
          content: SizedBox(
            width: Get.width,
            height: Get.height * 0.4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Adha wiyana",
                        style: GoogleFonts.readexPro(
                            fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      AnimatedRatingStars(
                          starSize: 20,
                          onChanged: (p0) {},
                          customFilledIcon: Icons.star_rounded,
                          customHalfFilledIcon: Icons.star_rounded,
                          customEmptyIcon: Icons.star_rounded
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Order ID",
                        style: GoogleFonts.readexPro(
                            fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "123xxxxx",
                        style: GoogleFonts.readexPro(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Biaya",
                        style: GoogleFonts.readexPro(
                            fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        convertToIdr(10000, 0),
                        style: GoogleFonts.readexPro(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Jarak",
                        style: GoogleFonts.readexPro(
                            fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '1 KM',
                        style: GoogleFonts.readexPro(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Pembayaran",
                        style: GoogleFonts.readexPro(
                            fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Cash',
                        style: GoogleFonts.readexPro(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  height: Get.height * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xFF3978EF),
                      )
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Jalan Merderka No.123, Jakarta pusat",
                    style: GoogleFonts.readexPro(
                        fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: Get.height * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        width: 1,
                        color: Colors.deepOrangeAccent,
                      )
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Jalan Merderka No.123, Jakarta pusat",
                    style: GoogleFonts.readexPro(
                        fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            OutlinedButton(
              onPressed: () {
                Get.back();
                showBottomSheet(true);
              },
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF3978EF), width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              child: Text(
                "Terima",
                style: GoogleFonts.readexPro(
                  fontSize: 12,
                  color: const Color(0xFF3978EF),
                ),
              )),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.deepOrange, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              child: Text(
                "Tolak",
                style: GoogleFonts.readexPro(
                  fontSize: 12,
                  color: Colors.deepOrange,
                ),
              )),
        ],
        ),
    );
  }

  settingDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
              'Pengaturan',
            style: GoogleFonts.readexPro(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          content: SizedBox(
            width: Get.width,
            height: Get.height * 0.15,
            child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: <Widget>[
                    Text(
                      "Otomatis menerima pesanan",
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Switch.adaptive(
                      activeColor: const Color(0xFF3978EF),
                      value: orderSetting.value,
                      onChanged: (value) => orderSetting(value),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                      "Akun siap bekerja",
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Switch.adaptive(
                      activeColor: const Color(0xFF3978EF),
                      value: accountSetting.value,
                      onChanged: (value) => accountSetting(value),
                    )
                  ],
                ),
              ],
            )),
          ),
          actionsAlignment: MainAxisAlignment.center,
        ),
    );
  }

}