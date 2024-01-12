import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/product/controller_product.dart';
import 'package:lugo_marchant/route/route_name.dart';

class PageProduct extends GetView<ControllerProduct> {
  const PageProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.loading.value == Status.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3978EF),
            ),
          );
        } else {
          return Expanded(
              child: ListView.builder(
            itemCount: controller.product.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        imageUrl: '${controller.product[index].image}',
                        errorWidget: (context, url, error) => const Image(
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/sample_food.png')),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "${controller.product[index].name}",
                            style: GoogleFonts.readexPro(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            '${controller.product[index].price}',
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            maxLines: 2,
                            '${controller.product[index].description}',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        AnimatedRatingStars(
                          starSize: 12,
                          readOnly: true,
                          initialRating: double.parse(
                              "${controller.product[index].count!.customerProductReview}"),
                          onChanged: (p0) {},
                          customEmptyIcon: Icons.star_rounded,
                          customFilledIcon: Icons.star_rounded,
                          customHalfFilledIcon: Icons.star_rounded,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                                onPressed: () =>
                                    Get.toNamed(Routes.editProduct, arguments: {
                                      "name": controller.product[index].name,
                                      "description":
                                          controller.product[index].description,
                                      "image": controller.product[index].image,
                                      "price": controller.product[index].price,
                                    }),
                                style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                child: const Text("Edit")),
                            const SizedBox(width: 10),
                            OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                child: const Text("Habis")),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.filterBottom(context),
        backgroundColor: const Color(0xFF3978EF),
        child: const Icon(
          color: Colors.white,
          Icons.filter_alt_rounded,
        ),
      ),
    );
  }
}
