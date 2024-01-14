import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/profile/controller_profile.dart';
import 'package:lugo_marchant/route/route_name.dart';

class PageProfile extends GetView<ControllerProfile> {
  const PageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.25),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Obx(() => Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    width: Get.width,
                    height: Get.height * 0.25,
                    fit: BoxFit.cover,
                    imageUrl: controller.merchant.value.avatar ?? "",
                    errorWidget: (context, url, error) => Image(
                      width: Get.width,
                      height: Get.height * 0.25,
                      fit: BoxFit.cover,
                      image: const AssetImage('assets/images/person.png'),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: Get.height * 0.25,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter,
                            colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ])),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Obx(
                          () => Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                controller.merchant.value.detail?.name ??
                                    "Nama Toko",
                                style: GoogleFonts.readexPro(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                controller.merchant.value.email ??
                                    "user@email.com",
                                style: GoogleFonts.readexPro(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Switch(
                            value: controller.storeOpen.value,
                            activeColor: const Color(0xFF3978EF),
                            onChanged: (value) {
                              controller.handleUpdateStoreOpen(value).then(
                                (it) {
                                  controller.storeOpen(value);
                                },
                              );
                            })
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.operationalTime),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(Get.width, Get.height * 0.055),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: const Color(0xFF3978EF)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Jam Buka",
                          style: GoogleFonts.readexPro(
                              fontSize: 12, color: Colors.white),
                        ),
                        const Spacer(),
                        const Icon(Icons.shopping_bag_rounded,
                            color: Colors.white)
                      ],
                    ),
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.accountInformation),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(Get.width, Get.height * 0.055),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: const Color(0xFF3978EF)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Informasi Akun",
                          style: GoogleFonts.readexPro(
                              fontSize: 12, color: Colors.white),
                        ),
                        const Spacer(),
                        const Icon(Icons.info_outline_rounded,
                            color: Colors.white)
                      ],
                    ),
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.privacyTerm),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(Get.width, Get.height * 0.055),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: const Color(0xFF3978EF)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Kebijakan Privasi",
                          style: GoogleFonts.readexPro(
                              fontSize: 12, color: Colors.white),
                        ),
                        const Spacer(),
                        const Icon(Icons.privacy_tip_outlined,
                            color: Colors.white)
                      ],
                    ),
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: ElevatedButton(
                  onPressed: () => controller.userHelp(context),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(Get.width, Get.height * 0.055),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: const Color(0xFF3978EF)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Bantuan",
                          style: GoogleFonts.readexPro(
                              fontSize: 12, color: Colors.white),
                        ),
                        const Spacer(),
                        const Icon(Icons.help_outline_rounded,
                            color: Colors.white)
                      ],
                    ),
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: ElevatedButton(
                  onPressed: () => controller.rateUs(context),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      fixedSize: Size(Get.width, Get.height * 0.055),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: const Color(0xFF3978EF)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Beri Rating",
                          style: GoogleFonts.readexPro(
                              fontSize: 12, color: Colors.white),
                        ),
                        const Spacer(),
                        const Icon(Icons.star_border_outlined,
                            color: Colors.white)
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
