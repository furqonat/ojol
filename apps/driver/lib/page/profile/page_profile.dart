import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_driver/route/route_name.dart';
import 'controller_profile.dart';

class PageProfile extends GetView<ControllerProfile> {
  const PageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.3),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Obx(() => Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    width: Get.width,
                    height: Get.height * 0.3,
                    fit: BoxFit.cover,
                    imageUrl: '${controller.cUser.value.avatar}',
                    errorWidget: (context, url, error) => Image(
                        width: Get.width,
                        height: Get.height * 0.3,
                        fit: BoxFit.cover,
                        image: const AssetImage('assets/images/person.png')),
                  ),
                  Container(
                    width: Get.width,
                    height: Get.height * 0.3,
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              controller.cUser.value.name ?? "user name",
                              style: GoogleFonts.readexPro(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              controller.cUser.value.email ?? "user@email.com",
                              style: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                fixedSize:
                                    Size(Get.width * 0.25, Get.height * 0.04),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                        color: Colors.white, width: 1)),
                                backgroundColor: Colors.transparent),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "Profile",
                                  style: GoogleFonts.readexPro(
                                      fontSize: 12, color: Colors.white),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: ElevatedButton(
                onPressed: () => Get.toNamed(Routes.orderSetting),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    fixedSize: Size(Get.width, Get.height * 0.07),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: const Color(0xFF3978EF)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Setting Order",
                    style: GoogleFonts.readexPro(
                        fontSize: 12, color: Colors.white),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    fixedSize: Size(Get.width, Get.height * 0.07),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: const Color(0xFF3978EF)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Syarat Ketentuan",
                    style: GoogleFonts.readexPro(
                        fontSize: 12, color: Colors.white),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: ElevatedButton(
                onPressed: () => controller.userHelp(context),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    fixedSize: Size(Get.width, Get.height * 0.07),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: const Color(0xFF3978EF)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bantuan",
                    style: GoogleFonts.readexPro(
                        fontSize: 12, color: Colors.white),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    fixedSize: Size(Get.width, Get.height * 0.07),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: const Color(0xFF3978EF)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Keluar",
                    style: GoogleFonts.readexPro(
                        fontSize: 12, color: Colors.white),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
