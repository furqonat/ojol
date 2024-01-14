import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/operational/controller_operational.dart';

class PageOperational extends GetView<ControllerOperational> {
  const PageOperational({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: InkWell(
            onTap: () => Get.back(),
            child: Card(
              elevation: 0,
              color: const Color(0xFF3978EF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: const Center(
                child: Icon(Icons.chevron_left, size: 24, color: Colors.white),
              ),
            )),
        actions: [
          Obx(() => Switch.adaptive(
                activeColor: const Color(0xFF3978EF),
                value: controller.shopStatus.value,
                onChanged: (value) => controller.shopStatus(value),
              ))
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.aInput.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(() => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          controller.aInput[index]['Hari'],
                          style: GoogleFonts.readexPro(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.readexPro(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              const TextSpan(text: 'Jam buka: '),
                              TextSpan(
                                  text: controller
                                      .aInput[index]["Jam buka"].value,
                                  style: GoogleFonts.readexPro(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF3978EF),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      final selectedTime = await showTimePicker(
                                        context: context,
                                        initialTime: controller.timeOpen.value,
                                      );

                                      if (selectedTime != null) {
                                        controller.aInput[index]["Jam buka"]
                                                .value =
                                            selectedTime
                                                .format(context)
                                                .toString();
                                      }
                                    }),
                              const TextSpan(text: ' - Jam tutup: '),
                              TextSpan(
                                text:
                                    controller.aInput[index]["Jam tutup"].value,
                                style: GoogleFonts.readexPro(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF3978EF),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    final selectedTime = await showTimePicker(
                                      context: context,
                                      initialTime: controller.timeClose.value,
                                    );

                                    if (selectedTime != null) {
                                      controller.aInput[index]["Jam tutup"]
                                              .value =
                                          selectedTime
                                              .format(context)
                                              .toString();
                                    }
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Switch.adaptive(
                      activeColor: const Color(0xFF3978EF),
                      value: controller.aInput[index]['Status'].value,
                      onChanged: (value) =>
                          controller.aInput[index]['Status'].value = value,
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}
