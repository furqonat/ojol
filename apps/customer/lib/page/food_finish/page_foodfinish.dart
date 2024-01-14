import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/food_finish/controller_foodfinish.dart';

import '../../route/route_name.dart';

class PageFoodFinish extends GetView<ControllerFoodFinish>{
  const PageFoodFinish({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
              child: Row(
                children: <Widget>[
                  const Image(
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                      image: AssetImage('assets/images/2023-05-05_(4).png')
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'User name',
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'B xxxx AA',
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Mio J',
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'ID Order | 123xxxxx',
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                    "Pembayaran",
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3978EF)
                    )
                ),
                Text(
                    "Cash",
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87
                    )
                ),
              ],
            )
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: Center(
                child: Text(
                    "Rp 8.000",
                    style: GoogleFonts.readexPro(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87
                    )
                ),
              ),
            )
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                      'Rating Kurir',
                      style: GoogleFonts.readexPro(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3978EF),
                      )
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
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 10, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                      'Rating Toko',
                      style: GoogleFonts.readexPro(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3978EF),
                      )
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
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}