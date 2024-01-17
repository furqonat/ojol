import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_driver/response/room.dart';
import '../../route/route_name.dart';
import 'controller_roomchat.dart';

class PageRoomChat extends GetView<ControllerRoomChat> {
  const PageRoomChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: TabBar(
              labelColor: const Color(0xFF14181B),
              indicatorColor: const Color(0xFF4B39EF),
              labelStyle: GoogleFonts.outfit(
                fontSize: 20,
              ),
              padding: const EdgeInsets.all(10),
              unselectedLabelStyle: GoogleFonts.outfit(
                fontSize: 20,
                color: const Color(0xFF95A1AC),
              ),
              controller: controller.tabController,
              tabs: const [
                Tab(
                  text: 'Merchant',
                ),
                Tab(
                  text: 'Customer',
                ),
              ]),
        ),
      ),
      body: TabBarView(controller: controller.tabController, children: [
        //pakai nama merchant
        StreamBuilder<List<RoomChat>>(
          stream: controller.getRoomChat(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Get.toNamed(Routes.chat),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      imageUrl: "",
                      errorWidget: (context, url, error) => SizedBox(
                        width: 50,
                        height: 50,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(Icons.person_rounded,
                              size: 30, color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    "user name",
                    style: GoogleFonts.readexPro(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Pesanan selesai",
                    style: GoogleFonts.readexPro(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ));
            } else {
              return const Center(
                child: Text("Ada yang salah"),
              );
            }
          },
        ),
        //pakai nama user
        StreamBuilder<List<RoomChat>>(
          stream: controller.getRoomChat(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Get.toNamed(Routes.chat),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      imageUrl: "",
                      errorWidget: (context, url, error) => SizedBox(
                        width: 50,
                        height: 50,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(Icons.person_rounded,
                              size: 30, color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    "user name",
                    style: GoogleFonts.readexPro(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Pesanan selesai",
                    style: GoogleFonts.readexPro(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ));
            } else {
              return const Center(
                child: Text("Ada yang salah"),
              );
            }
          },
        ),
      ]),
    );
  }
}
