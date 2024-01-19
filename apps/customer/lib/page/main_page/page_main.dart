import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/main_page/controller_main.dart';
import 'package:lugo_customer/route/route_name.dart';

class PageMain extends GetView<ControllerMain> {
  const PageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CarouselSlider.builder(
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
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.saldo),
                  child: Container(
                    width: Get.width * 0.47,
                    height: Get.height * 0.08,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xFF3978EF),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Dana | Rp 20.000",
                      style: GoogleFonts.readexPro(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.point),
                  child: Container(
                    width: Get.width * 0.47,
                    height: Get.height * 0.08,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color(0xFF3978EF),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Poin | Rp 20.000",
                      style: GoogleFonts.readexPro(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(width: 1, color: Colors.grey.shade300)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () => Get.offAllNamed(Routes.location_picker,
                            arguments: {"request_type": "rider"}),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              width: 50,
                              height: 50,
                              image: AssetImage(
                                  'assets/images/2023-05-05__2_-removebg-preview.png'),
                            ),
                            Text(
                              "Lu-Ride",
                              style: GoogleFonts.readexPro(
                                color: const Color(0xFF3978EF),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () => Get.offAllNamed(Routes.location_picker,
                            arguments: {"request_type": "driver"}),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              width: 50,
                              height: 50,
                              image:
                                  AssetImage('assets/images/1696044585451.png'),
                            ),
                            Text(
                              "Lu-Car",
                              style: GoogleFonts.readexPro(
                                color: const Color(0xFF3978EF),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () => Get.offAllNamed(Routes.location_picker,
                            arguments: {"request_type": "delivery"}),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              width: 50,
                              height: 50,
                              image: AssetImage(
                                  'assets/images/2023-05-05__3_-removebg-preview.png'),
                            ),
                            Text(
                              "Lu-Deliv",
                              style: GoogleFonts.readexPro(
                                color: const Color(0xFF3978EF),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () => Get.toNamed(Routes.food),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              width: 50,
                              height: 50,
                              image: AssetImage(
                                  'assets/images/2023-05-05__1_-removebg-preview.png'),
                            ),
                            Text(
                              "Lu-Food",
                              style: GoogleFonts.readexPro(
                                color: const Color(0xFF3978EF),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () => Get.toNamed(Routes.mart),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Image(
                              width: 50,
                              height: 50,
                              image: AssetImage(
                                  'assets/images/2023-05-05-removebg-preview.png'),
                            ),
                            Text(
                              "Lu-Mart",
                              style: GoogleFonts.readexPro(
                                color: const Color(0xFF3978EF),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CarouselSlider.builder(
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
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                  child: Text(
                    "Rekomendasi untuk anda",
                    style: GoogleFonts.readexPro(
                      fontSize: 16,
                      color: const Color(0xFF3978EF),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: CarouselSlider.builder(
                      itemCount: 5,
                      options: CarouselOptions(
                        initialPage: 0,
                        autoPlay: true,
                        viewportFraction: 0.5,
                      ),
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Stack(
                            children: <Widget>[
                              const Image(
                                  image: AssetImage(
                                      "assets/images/empty_image.jpg")),
                              Container(
                                width: Get.width,
                                height: Get.height * 0.22,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black38
                                        ]),
                                    borderRadius: BorderRadius.circular(10)),
                                padding:
                                    const EdgeInsets.only(left: 12, bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "Contoh Produk",
                                      style: GoogleFonts.readexPro(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Rp 10.000",
                                      style: GoogleFonts.readexPro(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
