import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lugo_customer/page/chat/controller_chat.dart';

class PageChat extends GetView<ControllerChat>{
  const PageChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3978EF),
        foregroundColor: Colors.white,
        title: Text(
            'Username',
          style: GoogleFonts.readexPro(
            fontSize: 18,
          ),
        ),
        leading: InkWell(
          onTap: ()=> Get.back(),
          child: const Icon(Icons.chevron_left_rounded),
        ),
        actions: [
          InkWell(
            onTap: (){},
            child: const SizedBox(
              width: 55,
              height: 55,
              child: Icon(Icons.delete_rounded),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: controller.samplechat.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: controller.samplechat[index]['user']! == 'user_1'
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.fromLTRB(8, 8, 8, controller.samplechat[index]['attachment']! != '' ? 0 : 8),
                      decoration: BoxDecoration(
                        color: controller.samplechat[index]['user']! == 'user_1'
                            ? const Color(0xFF3978EF)
                            : const Color(0xFF3978EF).withOpacity(0.6),
                        borderRadius: controller.samplechat[index]['user']! == 'user_1'
                            ? const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        )
                            : const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: controller.samplechat[index]['user']! == 'user_1'
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            controller.samplechat[index]['msg']!,
                            style: GoogleFonts.readexPro(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            DateFormat('HH:mm').format(DateTime.now()),
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: controller.samplechat[index]['attachment']! != '' ? true : false,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: controller.samplechat[index]['user']! == 'user_1'
                                    ? const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                )
                                    : const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                )
                            ),
                            child: ClipRRect(
                              borderRadius: controller.samplechat[index]['user']! == 'user_1'
                                  ? const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              )
                                  : const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              child: Image(
                                  width: Get.width * 0.7,
                                  image: AssetImage(
                                      controller.samplechat[index]['attachment']!
                                  )
                              ),
                            ),
                          ),
                        )
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: Get.width,
              height: Get.height * 0.08,
              child: Card(
                elevation: 0,
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: Get.width * 0.6,
                        height: 50,
                        child: TextFormField(
                          controller: controller.edtChat,
                          style: GoogleFonts.readexPro(
                              fontSize: 14
                          ),
                          decoration: InputDecoration(
                              hintText: 'Tulis Pesan',
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.readexPro(
                                  fontSize: 14
                              )
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: InkWell(
                          onTap: (){},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)
                            ),
                            color: const Color(0xFF3978EF),
                            child: const Icon(Icons.camera_enhance_rounded, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: InkWell(
                          onTap: (){},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)
                            ),
                            color: const Color(0xFF3978EF),
                            child: const Icon(Icons.send_rounded, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}