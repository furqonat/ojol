import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/home/controller_home.dart';
import 'package:lugo_marchant/route/route_name.dart';
import 'package:lugo_marchant/shared/utils.dart';

class PageHome extends GetView<ControllerHome> {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Obx(
                () => Text(
                  controller.merchant.value.detail?.name ?? '',
                  style: GoogleFonts.readexPro(
                      fontSize: 24,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: Get.width,
              height: Get.height * 0.12,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF3978EF),
                    Color(0xFF6C9EFF),
                  ],
                ),
              ),
              child: Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Icon(
                      size: 35,
                      Icons.check_box,
                      color: Colors.white,
                    ),
                  ),
                  Obx(
                    () => RichText(
                      text: TextSpan(
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'Penjualan hari ini\n'),
                          TextSpan(
                              text: intlNumberCurrency(
                                controller.sell.value.totalIncome,
                              ),
                              style: GoogleFonts.readexPro(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: SizedBox(
                width: Get.width,
                height: Get.height * 0.07,
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Obx(
                        () => Text(
                          '${controller.sell.value.totalDone} Pesanan Berhasil',
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: Colors.grey,
                      ),
                      Obx(
                        () => Text(
                          '${controller.sell.value.totalCancel} Pesanan Batal',
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.fromLTRB(20, 25, 20, 5),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: <Widget>[
                  Text(
                    'Saldo',
                    style: GoogleFonts.readexPro(
                        fontSize: 26,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Obx(
                          () => GestureDetector(
                            onTap: () => Get.toNamed(Routes.danaBalance),
                            child: controller.loadingDana.value
                                ? const CircularProgressIndicator()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Image(
                                        width: 95,
                                        image: AssetImage(
                                          'assets/images/1699744330264.png',
                                        ),
                                      ),
                                      controller.merchant.value.danaToken ==
                                              null
                                          ? ElevatedButton(
                                              onPressed: () {
                                                controller
                                                    .handleGenerateSignInUrl();
                                              },
                                              child:
                                                  const Text("Hubungkan Akun"),
                                            )
                                          : displayDanaBalance(),
                                    ],
                                  ),
                          ),
                        ),
                        Container(
                          width: 1,
                          color: Colors.grey,
                          height: Get.height * 0.06,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.account_balance_wallet_rounded,
                              size: 26,
                              color: Colors.black87,
                            ),
                            Obx(
                              () => Text(
                                intlNumberCurrency(
                                  controller.merchant.value.wallet?.balance,
                                ),
                                style: GoogleFonts.readexPro(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(Routes.product),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            size: 32,
                            CupertinoIcons.tag_fill,
                            color: Color(0xFF3978EF),
                          ),
                          Text(
                            "Jualan",
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
                      onTap: () => Get.toNamed(Routes.category),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            size: 32,
                            Icons.category,
                            color: Color(0xFF3978EF),
                          ),
                          Text(
                            "Kategori",
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
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            size: 32,
                            CupertinoIcons.money_dollar_circle,
                            color: Color(0xFF3978EF),
                          ),
                          Text(
                            "Saldo",
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
                      onTap: () => Get.toNamed(Routes.promo),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Icon(
                            size: 32,
                            Icons.discount,
                            color: Color(0xFF3978EF),
                          ),
                          Text(
                            "Promo",
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CarouselSlider.builder(
                itemCount: controller.listImg.length,
                options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    aspectRatio: 1.7,
                    initialPage: 0),
                itemBuilder: (context, index, realIndex) {
                  return Image(
                    fit: BoxFit.fill,
                    width: Get.width,
                    image: AssetImage(
                      controller.listImg[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget displayDanaBalance() {
    final balance = controller.danaProfile.where((dana) {
      return dana.resourceType == 'BALANCE';
    }).first;
    return Column(
      children: [
        Text(
          intlNumberCurrency(int.parse(balance.value)),
          style: GoogleFonts.readexPro(
            fontSize: 24,
          ),
        )
      ],
    );
  }
}
