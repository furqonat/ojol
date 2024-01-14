import 'dart:io';

import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/delivery_finish/controller_delivfinish.dart';
import 'package:lugo_customer/route/route_name.dart';

class PageDelivFinish extends GetView<ControllerDelivFinish>{
  const PageDelivFinish({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 35, 35, 0),
              child: Center(
                child: Text(
                  'Paket Sudah Terkirim',
                  style: GoogleFonts.readexPro(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: ()=> showDialog(
                    context: context,
                    builder: (context)=> AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      title: Text(
                        'Upload gambar anda berdasarkan?',
                        style: GoogleFonts.readexPro(
                            fontSize: 12
                        ),
                      ),
                      actions: [
                        OutlinedButton(
                            onPressed: (){
                              Get.back();
                              controller.getFromFile();
                            },
                            child: Text(
                              'Gallery',
                              style: GoogleFonts.readexPro(
                                  fontSize: 12
                              ),
                            )
                        ),
                        OutlinedButton(
                            onPressed: (){
                              Get.back();
                              controller.getFromCamera();
                            },
                            child: Text(
                              'Camera',
                              style: GoogleFonts.readexPro(
                                  fontSize: 12
                              ),
                            )
                        )
                      ],
                    )
                ),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: controller.imgPreview.value == ''
                        ? Image(
                        width: Get.width,
                        image: const AssetImage('assets/images/paket_sampai.jpg')
                    )
                        :Image.file(
                        width: Get.width,
                        height: Get.height * 0.3,
                        fit: BoxFit.cover,
                        File(controller.imgPreview.value)
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Nama Penerima',
                    style: GoogleFonts.readexPro(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 50,
                      width: Get.width * 0.5,
                      child: TextFormField(
                        style: GoogleFonts.readexPro(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nama penerima'
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                      'Biaya',
                      style: GoogleFonts.readexPro(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3978EF),
                      )
                  ),
                  Text(
                      'Cash',
                      style: GoogleFonts.readexPro(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      )
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Center(
                child: Text(
                    'Rp 20.000',
                    style: GoogleFonts.readexPro(
                      fontSize: 22,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    )
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                'Rating Driver',
                                style: GoogleFonts.readexPro(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                )
                            ),
                            Text(
                                'Tuliskan ualasan kamu',
                                style: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  color: Colors.black87,
                                )
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AnimatedRatingStars(
                            starSize: 16,
                            initialRating: 0,
                            onChanged: (p0) {},
                            customEmptyIcon: Icons.star,
                            customFilledIcon: Icons.star,
                            customHalfFilledIcon: Icons.star,
                          ),
                        )
                      ],
                    ),
                    ElevatedButton(
                        onPressed: ()=> Get.offAllNamed(Routes.home),
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            fixedSize: Size(Get.width, Get.height * 0.06),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            backgroundColor: const Color(0xFF3978EF)
                        ),
                        child: Text(
                          "Selesai",
                          style: GoogleFonts.readexPro(
                              fontSize: 16,
                              color: Colors.white
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )
      ),
    );
  }
}