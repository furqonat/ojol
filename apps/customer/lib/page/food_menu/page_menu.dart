import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/shared/utils.dart';
import '../../route/route_name.dart';
import 'controller_menu.dart';

class PageFoodMenu extends GetView<ControllerFoodMenu> {
  const PageFoodMenu({super.key});

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
      body: Obx(() => Padding(
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
                  child: controller.loading.value == Status.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Color(0xFF3978EF),
                        ))
                      : controller.loading.value == Status.success
                          ? ListView.builder(
                              itemCount: controller.product.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 5, 5),
                                  child: InkWell(
                                    onTap: () => controller.detailProduct(
                                        context,
                                        "${controller.product[index].image}",
                                        "${controller.product[index].name}",
                                        controller.product[index].price ?? 0,
                                        "${controller.product[index].description}",
                                        controller
                                            .favoriteStatus[index]["status"]
                                            .value),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: CachedNetworkImage(
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  '${controller.product[index].image}',
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Image(
                                                      width: 80,
                                                      height: 80,
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          'assets/images/sample_food.png')),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${controller.product[index].name}",
                                              style: GoogleFonts.readexPro(
                                                fontSize: 16,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              convertToIdr(
                                                  controller
                                                      .product[index].price,
                                                  0),
                                              style: GoogleFonts.readexPro(
                                                fontSize: 12,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            AnimatedRatingStars(
                                              starSize: 12,
                                              readOnly: true,
                                              initialRating: double.parse(
                                                  "${controller.product[index].count?.customerProductReview}"),
                                              onChanged: (p0) {},
                                              customEmptyIcon:
                                                  Icons.star_rounded,
                                              customFilledIcon:
                                                  Icons.star_rounded,
                                              customHalfFilledIcon:
                                                  Icons.star_rounded,
                                            )
                                          ],
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          height: 70,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Obx(() => Row(
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: () => controller
                                                            .postLikeProductMethod(
                                                                controller
                                                                    .product[
                                                                        index]
                                                                    .id!,
                                                                index),
                                                        child: Icon(
                                                          size: 24,
                                                          color: controller
                                                                  .favoriteStatus[
                                                                      index]
                                                                      ["status"]
                                                                  .value
                                                              ? Colors.pink
                                                                  .withOpacity(
                                                                      0.7)
                                                              : const Color(
                                                                  0xFF3978EF),
                                                          Icons.favorite,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () => controller
                                                            .cartMethod(
                                                                "${controller.product[index].id}",
                                                                controller
                                                                    .listQuantity[
                                                                        index][
                                                                        'quantity']
                                                                    .value,
                                                                controller
                                                                    .product[
                                                                        index]
                                                                    .price!),
                                                        child: const Icon(
                                                          size: 24,
                                                          Icons
                                                              .shopping_bag_rounded,
                                                          color:
                                                              Color(0xFF3978EF),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Obx(() => Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: () {
                                                          controller
                                                                      .listQuantity[
                                                                          index]
                                                                          [
                                                                          "quantity"]
                                                                      .value ==
                                                                  0
                                                              ? controller
                                                                  .listQuantity[
                                                                      index][
                                                                      "quantity"]
                                                                  .value = 0
                                                              : controller
                                                                  .listQuantity[
                                                                      index][
                                                                      "quantity"]
                                                                  .value = controller
                                                                      .listQuantity[
                                                                          index]
                                                                          [
                                                                          "quantity"]
                                                                      .value -
                                                                  1;
                                                        },
                                                        child: const Icon(
                                                            CupertinoIcons
                                                                .minus_circle_fill,
                                                            color: Color(
                                                                0xFF3978EF)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                          "${controller.listQuantity[index]["quantity"].value}",
                                                          style: GoogleFonts
                                                              .readexPro(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black87,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          controller
                                                              .listQuantity[
                                                                  index]
                                                                  ["quantity"]
                                                              .value += 1;
                                                        },
                                                        child: const Icon(
                                                            CupertinoIcons
                                                                .add_circled_solid,
                                                            color: Color(
                                                                0xFF3978EF)),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : controller.loading.value == Status.failed
                              ? Center(
                                  child: Text(
                                    "Ada yang salah",
                                    style: GoogleFonts.readexPro(
                                      fontSize: 18,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : controller.product.isEmpty
                                  ? Center(
                                      child: Text(
                                        "Toko ini tidak punya produk apapun untuk di jual",
                                        style: GoogleFonts.readexPro(
                                          fontSize: 18,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                ),
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
                      const Icon(Icons.shopping_bag_rounded,
                          color: Colors.white),
                      Text(
                        convertToIdr(controller.total.value, 0),
                        style: GoogleFonts.readexPro(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.food_pay);
                        },
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
          )),
    );
  }
}
