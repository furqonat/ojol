import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../response/room.dart';
import '../../route/route_name.dart';
import 'controller_roomchat.dart';

class PageRoomChat extends GetView<ControllerRoomChat>{
  const PageRoomChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<RoomChat>>(
        stream: controller.getRoomChat(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () => Get.toNamed(Routes.chat, arguments: {
                      'orderTransaksiId' : snapshot.data?[index].id,
                      'sendTo' : "MERCHANT"
                    }),
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
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: const Icon(Icons.person_rounded, size: 30, color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      "${snapshot.data![index].driverId}",
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
                )
            );
          }else{
            return const Center(
              child: Text("Ada yang salah"),
            );
          }
        },
      ),
    );
  }
}