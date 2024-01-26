import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/product/controller_product.dart';
import 'package:lugo_marchant/route/route_name.dart';
import 'package:lugo_marchant/shared/utils.dart';

class PageProduct extends GetView<ControllerProduct> {
  const PageProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("Produk Saya"),
      ),
      body: Obx(
        () {
          if (controller.loading.value == Status.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3978EF),
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
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
                              child: Image.network(
                                '${controller.product[index].image}',
                                width: 120,
                                height: 150,
                                fit: BoxFit.cover,
                                errorBuilder: (context, url, error) =>
                                    const Image(
                                  width: 120,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/sample_food.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.50,
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
                                    intlNumberCurrency(
                                      controller.product[index].price,
                                    ),
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
                                    controller.product[index].description !=
                                            null
                                        ? '${controller.product[index].description}'
                                        : "",
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
                                      onPressed: () => Get.toNamed(
                                        Routes.editProduct,
                                        arguments: {
                                          "id": controller.product[index].id
                                        },
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text("Edit"),
                                    ),
                                    const SizedBox(width: 10),
                                    OutlinedButton(
                                      onPressed: () {
                                        controller.handleSetEmptyProduct(
                                          controller.product[index].id ?? '',
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text("Habis"),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => filterBottom(context),
        backgroundColor: const Color(0xFF3978EF),
        child: const Icon(
          color: Colors.white,
          Icons.filter_alt_rounded,
        ),
      ),
    );
  }

  filterBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        width: Get.width,
        height: Get.height * 0.25,
        child: Obx(
          () => Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: DropdownButton<String>(
                  elevation: 2,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFF95A1AC),
                    size: 24,
                  ),
                  value: controller.category.value,
                  borderRadius: BorderRadius.circular(8),
                  underline: const SizedBox(),
                  isExpanded: true,
                  items: controller.categories.map((element) {
                    return DropdownMenuItem(
                      value: element.name,
                      child: Text(
                        element.name,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) => controller.category(value),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    controller.getProducts().then((value) {
                      Get.back();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(Get.width, Get.height * 0.06),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: const Color(0xFF3978EF)),
                  child: Text(
                    "Lanjutkan",
                    style: GoogleFonts.readexPro(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
