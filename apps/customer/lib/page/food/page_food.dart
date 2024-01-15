import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/food/controller_food.dart';
import 'package:lugo_customer/route/route_name.dart';

class PageFood extends GetView<ControllerFood> {
  const PageFood({super.key});

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
        actions: [
          InkWell(
              onTap: () => Get.toNamed(Routes.history_food),
              child: SizedBox(
                width: 55,
                height: 55,
                child: Card(
                  elevation: 0,
                  color: const Color(0xFF3978EF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: const Center(
                    child: Icon(Icons.list_alt_rounded,
                        size: 24, color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(() => Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: controller.edtSearch,
                      decoration: InputDecoration(
                          hintText: 'Mau makan apa?',
                          hintStyle: GoogleFonts.readexPro(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xFF95A1AC),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFF4B39EF))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFF1D2428))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.red)),
                          contentPadding: const EdgeInsets.all(24)),
                    ),
                  ),
                ),
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
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: DropdownButton<String>(
                    elevation: 2,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF95A1AC),
                      size: 24,
                    ),
                    underline: const SizedBox(),
                    dropdownColor: Colors.white,
                    value: controller.categoryType.value,
                    items: controller.categoryTypeList.map((element) {
                      return DropdownMenuItem(
                        value: element,
                        child: Text(
                          element,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) =>
                        controller.categoryType(value),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.toNamed(Routes.food_menu),
                      child: Padding(
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
                                    image: AssetImage(
                                        'assets/images/sample_food.png')),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nama Toko",
                                  style: GoogleFonts.readexPro(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.star_rounded,
                                        color: Colors.deepOrangeAccent),
                                    Container(
                                      width: 1,
                                      height: 20,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      decoration: const BoxDecoration(
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "2 KM",
                                      style: GoogleFonts.readexPro(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 20,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      decoration: const BoxDecoration(
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "20 Menit",
                                      style: GoogleFonts.readexPro(
                                        fontSize: 12,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ))
              ],
            )),
      ),
    );
  }
}
