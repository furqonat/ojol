import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/menu/controller_menu.dart';
import 'package:lugo_customer/route/route_name.dart';

class PageMenu extends GetView<ControllerMenu> {
  const PageMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: InkWell(
            onTap: () => Get.back(),
            child: SizedBox(
              width: 55,
              height: 55,
              child: Card(
                elevation: 0,
                color: const Color(0xFF3978EF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: const Center(
                  child:
                      Icon(Icons.chevron_left, size: 24, color: Colors.white),
                ),
              ),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CarouselSlider.builder(
              itemCount: controller.listImg.length,
              options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                  aspectRatio: 2,
                  initialPage: 0),
              itemBuilder: (context, index, realIndex) {
                return Image(
                    fit: BoxFit.fill,
                    width: Get.width,
                    image: AssetImage(controller.listImg[index]));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Daftar Menu",
                style: GoogleFonts.readexPro(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const Image(
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/images/sample_food.png')),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mie ayam",
                            style: GoogleFonts.readexPro(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Rp 10.000",
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 5),
                          AnimatedRatingStars(
                            starSize: 12,
                            readOnly: true,
                            initialRating: 5,
                            onChanged: (p0) {},
                            customEmptyIcon: Icons.star_rounded,
                            customFilledIcon: Icons.star_rounded,
                            customHalfFilledIcon: Icons.star_rounded,
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.transparent,
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(CupertinoIcons.minus,
                                      color: Color(0xFF3978EF)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "0",
                                    style: GoogleFonts.readexPro(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(CupertinoIcons.add,
                                      color: Color(0xFF3978EF)),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              size: 30,
                              color: Color(0xFF3978EF),
                              Icons.shopping_cart_rounded,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            )),
            Container(
              width: Get.width,
              height: Get.height * 0.07,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: const Color(0xFF3978EF),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Icon(Icons.shopping_bag_rounded, color: Colors.white),
                  Text(
                    "Rp 20.000",
                    style: GoogleFonts.readexPro(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.food_pay),
                    child: Text(
                      "Order",
                      style: GoogleFonts.readexPro(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
