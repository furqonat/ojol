import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../response/chat.dart';
import 'controller_chat.dart';

class PageChat extends GetView<ControllerChat> {
  const PageChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3978EF),
        foregroundColor: Colors.white,
        title: Text(
          'Ruang pesan',
          style: GoogleFonts.readexPro(
            fontSize: 18,
          ),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.chevron_left_rounded),
        ),
      ),
      body: Obx(() {
        if (controller.roomType.value == 'CUSTOMER') {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              StreamBuilder<List<Chat>>(
                  stream: controller.getChat(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Text(
                              "Tidak ada pesan yang ditampilkan pada obrolan ini",
                              style: GoogleFonts.readexPro(fontSize: 12)));
                    } else {
                      return snapshot.data!.isNotEmpty
                          ? ListView.builder(
                        itemCount: snapshot.data?.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment:
                            snapshot.data?[index].idSender ==
                                controller
                                    .controllerUser.user.value.id
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                margin: EdgeInsets.fromLTRB(
                                    8,
                                    8,
                                    8,
                                    snapshot.data![index].attachment!
                                        .isNotEmpty
                                        ? 0
                                        : 8),
                                decoration: BoxDecoration(
                                  color: snapshot.data?[index].idSender ==
                                      controller.controllerUser.user
                                          .value.id
                                      ? const Color(0xFF3978EF)
                                      : const Color(0xFF3978EF)
                                      .withOpacity(0.6),
                                  borderRadius: snapshot
                                      .data?[index].idSender ==
                                      controller.controllerUser.user
                                          .value.id
                                      ? const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  )
                                      : const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomRight:
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  snapshot.data?[index].idSender ==
                                      controller.controllerUser
                                          .user.value.id
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data![index].msg!,
                                      style: GoogleFonts.readexPro(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      DateFormat('HH:mm').format(
                                          snapshot.data![index].time!),
                                      style: GoogleFonts.readexPro(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                  visible:
                                  snapshot.data?[index].attachment ==
                                      '' ||
                                      snapshot.data?[index]
                                          .attachment ==
                                          null
                                      ? false
                                      : true,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: snapshot
                                              .data?[index]
                                              .idSender ==
                                              controller
                                                  .controllerUser
                                                  .user
                                                  .value
                                                  .id
                                              ? const BorderRadius.only(
                                            topLeft:
                                            Radius.circular(15),
                                            topRight:
                                            Radius.circular(15),
                                            bottomLeft:
                                            Radius.circular(15),
                                          )
                                              : const BorderRadius.only(
                                            topLeft:
                                            Radius.circular(15),
                                            topRight:
                                            Radius.circular(15),
                                            bottomRight:
                                            Radius.circular(15),
                                          )),
                                      child: ClipRRect(
                                        borderRadius: snapshot
                                            .data?[index]
                                            .idSender ==
                                            controller.controllerUser
                                                .user.value.id
                                            ? const BorderRadius.only(
                                          topLeft:
                                          Radius.circular(15),
                                          topRight:
                                          Radius.circular(15),
                                          bottomLeft:
                                          Radius.circular(15),
                                        )
                                            : const BorderRadius.only(
                                          topLeft:
                                          Radius.circular(15),
                                          topRight:
                                          Radius.circular(15),
                                          bottomRight:
                                          Radius.circular(15),
                                        ),
                                        child: CachedNetworkImage(
                                          width: Get.width * 0.7,
                                          imageUrl: snapshot
                                              .data![index].attachment!,
                                          errorWidget: (context, url,
                                              error) =>
                                              Image(
                                                  width: Get.width * 0.5,
                                                  image: const AssetImage(
                                                      'assets/images/sample_food.png')),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          );
                        },
                      )
                          : const Center(
                        child:
                        Text("Tidak ada pesan yang bisa ditampilkan"),
                      );
                    }
                  }),
              Obx(() => Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: Get.width,
                  height: controller.showAttachment.value == false
                      ? Get.height * 0.085
                      : Get.height * 0.3,
                  child: Card(
                    elevation: 0,
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Visibility(
                            visible: controller.showAttachment.value,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                    width: Get.width,
                                    height: Get.height * 0.2,
                                    fit: BoxFit.cover,
                                    File(controller.view.value)),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment:
                            controller.showAttachment.value == false
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(
                                width: Get.width * 0.6,
                                height: 50,
                                child: TextFormField(
                                  controller: controller.edtChat,
                                  style:
                                  GoogleFonts.readexPro(fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Tulis Pesan',
                                      border: InputBorder.none,
                                      hintStyle: GoogleFonts.readexPro(
                                          fontSize: 12)),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () =>
                                      controller.pickImage(context),
                                  style: const ButtonStyle(
                                      backgroundColor:
                                      MaterialStatePropertyAll(
                                          Color(0xFF3978EF)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      100))))),
                                  icon: const Icon(Icons.camera_rounded,
                                      color: Colors.white)),
                              IconButton(
                                  onPressed: () {
                                    controller.sendChat();
                                    controller.view.value == '';
                                    controller.upload.value == '';
                                    controller.showAttachment.value = false;
                                    controller.edtChat.text = '';
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor:
                                      MaterialStatePropertyAll(
                                          Color(0xFF3978EF)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      100))))),
                                  icon: const Icon(Icons.send_rounded,
                                      color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              StreamBuilder<List<Chat>>(
                  stream: controller.getChatMerchant(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Text(
                              "Tidak ada pesan yang ditampilkan pada obrolan ini",
                              style: GoogleFonts.readexPro(fontSize: 12)));
                    } else {
                      return snapshot.data!.isNotEmpty
                          ? ListView.builder(
                        itemCount: snapshot.data?.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment:
                            snapshot.data?[index].idSender ==
                                controller
                                    .controllerUser.user.value.id
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                margin: EdgeInsets.fromLTRB(
                                    8,
                                    8,
                                    8,
                                    snapshot.data![index].attachment!
                                        .isNotEmpty
                                        ? 0
                                        : 8),
                                decoration: BoxDecoration(
                                  color: snapshot.data?[index].idSender ==
                                      controller.controllerUser.user
                                          .value.id
                                      ? const Color(0xFF3978EF)
                                      : const Color(0xFF3978EF)
                                      .withOpacity(0.6),
                                  borderRadius: snapshot
                                      .data?[index].idSender ==
                                      controller.controllerUser.user
                                          .value.id
                                      ? const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  )
                                      : const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomRight:
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  snapshot.data?[index].idSender ==
                                      controller.controllerUser
                                          .user.value.id
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data![index].msg!,
                                      style: GoogleFonts.readexPro(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      DateFormat('HH:mm').format(
                                          snapshot.data![index].time!),
                                      style: GoogleFonts.readexPro(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                  visible:
                                  snapshot.data?[index].attachment ==
                                      '' ||
                                      snapshot.data?[index]
                                          .attachment ==
                                          null
                                      ? false
                                      : true,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: snapshot
                                              .data?[index]
                                              .idSender ==
                                              controller
                                                  .controllerUser
                                                  .user
                                                  .value
                                                  .id
                                              ? const BorderRadius.only(
                                            topLeft:
                                            Radius.circular(15),
                                            topRight:
                                            Radius.circular(15),
                                            bottomLeft:
                                            Radius.circular(15),
                                          )
                                              : const BorderRadius.only(
                                            topLeft:
                                            Radius.circular(15),
                                            topRight:
                                            Radius.circular(15),
                                            bottomRight:
                                            Radius.circular(15),
                                          )),
                                      child: ClipRRect(
                                        borderRadius: snapshot
                                            .data?[index]
                                            .idSender ==
                                            controller.controllerUser
                                                .user.value.id
                                            ? const BorderRadius.only(
                                          topLeft:
                                          Radius.circular(15),
                                          topRight:
                                          Radius.circular(15),
                                          bottomLeft:
                                          Radius.circular(15),
                                        )
                                            : const BorderRadius.only(
                                          topLeft:
                                          Radius.circular(15),
                                          topRight:
                                          Radius.circular(15),
                                          bottomRight:
                                          Radius.circular(15),
                                        ),
                                        child: CachedNetworkImage(
                                          width: Get.width * 0.7,
                                          imageUrl: snapshot
                                              .data![index].attachment!,
                                          errorWidget: (context, url,
                                              error) =>
                                              Image(
                                                  width: Get.width * 0.5,
                                                  image: const AssetImage(
                                                      'assets/images/sample_food.png')),
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          );
                        },
                      )
                          : const Center(
                        child:
                        Text("Tidak ada pesan yang bisa ditampilkan"),
                      );
                    }
                  }),
              Obx(() => Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: Get.width,
                  height: controller.showAttachment.value == false
                      ? Get.height * 0.085
                      : Get.height * 0.3,
                  child: Card(
                    elevation: 0,
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Visibility(
                            visible: controller.showAttachment.value,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                    width: Get.width,
                                    height: Get.height * 0.2,
                                    fit: BoxFit.cover,
                                    File(controller.view.value)),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment:
                            controller.showAttachment.value == false
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(
                                width: Get.width * 0.6,
                                height: 50,
                                child: TextFormField(
                                  controller: controller.edtChat,
                                  style:
                                  GoogleFonts.readexPro(fontSize: 12),
                                  decoration: InputDecoration(
                                      hintText: 'Tulis Pesan',
                                      border: InputBorder.none,
                                      hintStyle: GoogleFonts.readexPro(
                                          fontSize: 12)),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () =>
                                      controller.pickImage(context),
                                  style: const ButtonStyle(
                                      backgroundColor:
                                      MaterialStatePropertyAll(
                                          Color(0xFF3978EF)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      100))))),
                                  icon: const Icon(Icons.camera_rounded,
                                      color: Colors.white)),
                              IconButton(
                                  onPressed: () {
                                    controller.sendChatMerchant();
                                    controller.view.value == '';
                                    controller.upload.value == '';
                                    controller.showAttachment.value = false;
                                    controller.edtChat.text = '';
                                  },
                                  style: const ButtonStyle(
                                      backgroundColor:
                                      MaterialStatePropertyAll(
                                          Color(0xFF3978EF)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      100))))),
                                  icon: const Icon(Icons.send_rounded,
                                      color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
            ],
          );
        }
      }),
    );
  }
}
