import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lugo_customer/page/room_chat/controller_roomchat.dart';
import 'package:lugo_customer/response/roomchat.dart';
import 'package:lugo_customer/route/route_name.dart';

class PageRoomChat extends GetView<ControllerRoomChat> {
  const PageRoomChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<RoomChat>>(
        stream: controller.getRoomChat(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return snapshot.data!.isNotEmpty
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.chat, arguments: {
                            'orderTransaksiId': snapshot.data?[index].id,
                          });
                        },
                        child: ListTile(
                          leading: SizedBox(
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
                          title: Text(
                            "${snapshot.data?[index].driverId}",
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "${DateFormat('dd/MM/yyyy').format(snapshot.data![index].dateTime!)} . ${snapshot.data?[index].status == true ? 'Online' : "Offline"}",
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                )
              : const Center(
                  child: Text("Tidak ada pesan untuk ditampilkan"),
                );
        }else if(snapshot.hasError){
            return Center(
              child: Text("Terjadi kesalahan\nErr_Code: ${snapshot.error}"),
            );
          }else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }
}
