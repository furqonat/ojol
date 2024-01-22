import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/food_pay/controller_foodpay.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:lugo_customer/shared/utils.dart';

class PageFoodPay extends GetView<ControllerFoodPay> {
  const PageFoodPay({super.key});

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
      body: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Detail Pesanan",
                  style: GoogleFonts.readexPro(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "ID Pesanan",
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "123xxxxx",
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.shopping_bag_rounded, color: Colors.grey),
                    Text(
                      "Nama Merchant",
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height * 0.35,
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: controller.loading.value == Status.success
                          ? ListView.builder(
                              itemCount: controller.carts.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(10),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
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
                                            imageUrl: controller.carts[index]
                                                    .product?.image ??
                                                "",
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${controller.carts[index].product?.name}",
                                              style: GoogleFonts.readexPro(
                                                fontSize: 16,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              convertToIdr(
                                                  controller.carts[index]
                                                      .product?.price,
                                                  0),
                                              style: GoogleFonts.readexPro(
                                                fontSize: 12,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Obx(() => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    InkWell(
                                                      onTap: () => controller
                                                          .updateCartMethod(
                                                              "${controller.carts[index].productId}",
                                                              controller
                                                                  .listQuantity[
                                                                      index][
                                                                      "quantity"]
                                                                  .value),
                                                      child: const Icon(
                                                          CupertinoIcons.pencil,
                                                          color: Color(
                                                              0xFF3978EF)),
                                                    ),
                                                    const Spacer(),
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
                                                                    index]
                                                                    ["quantity"]
                                                                .value = 0
                                                            : controller
                                                                .listQuantity[
                                                                    index]
                                                                    ["quantity"]
                                                                .value = controller
                                                                    .listQuantity[
                                                                        index][
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
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Text(
                                                        "${controller.listQuantity[index]["quantity"].value}",
                                                        style: GoogleFonts
                                                            .readexPro(
                                                          fontSize: 12,
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        controller
                                                            .listQuantity[index]
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
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : controller.loading.value == Status.failed
                              ? const Center(child: Text("Ada yang salah"))
                              : controller.loading.value == Status.loading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                          color: Color(0xFF3978EF)))
                                  : const SizedBox(),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 50,
                    width: Get.width,
                    child: TextFormField(
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF95A1AC),
                      ),
                      decoration: InputDecoration(
                          hintText: 'Kode diskon',
                          hintStyle: GoogleFonts.readexPro(
                            fontSize: 12,
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
                          suffixIcon: InkWell(
                            onTap: () {},
                            child: const Icon(Icons.check_box_rounded,
                                color: Colors.deepOrangeAccent),
                          )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                    text: TextSpan(
                        style: GoogleFonts.readexPro(
                          fontSize: 12,
                          color: const Color(0xFF3978EF),
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                      const TextSpan(text: 'ID Transaksi '),
                      TextSpan(
                          text: '123xxxxx',
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                            color: Colors.black87,
                          )),
                    ])),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Subtotal Makanan",
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      convertToIdr(controller.orderPrice.value, 0),
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Subtotal Kirim",
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Rp 0",
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
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
                  onChanged: (String? value) => controller.categoryType(value),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Total Pembayaran",
                          style: GoogleFonts.readexPro(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rp 0",
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.check_order,
                            arguments: {'request_type': 'food'}),
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            fixedSize: Size(Get.width * 0.3, Get.height * 0.03),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: const Color(0xFF3978EF)),
                        child: Text(
                          "Bayar",
                          style: GoogleFonts.readexPro(
                              fontSize: 12, color: Colors.white),
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
