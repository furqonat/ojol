import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/custom_widget/lugo_button.dart';
import 'controller_ordersetting.dart';

class PageOrderSetting extends GetView<ControllerOrderSetting> {
  const PageOrderSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF3978EF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
            icon: const Icon(Icons.chevron_left_rounded, color: Colors.white)),
      ),
      body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.orderSetting.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Obx(() => Row(
                      children: <Widget>[
                        SizedBox(
                          width: Get.width * 0.18,
                          child: Text(
                            '${controller.orderSetting[index]['Layanan']}',
                            style: GoogleFonts.readexPro(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF3978EF)),
                          ),
                        ),
                        Container(
                          width: Get.width * 0.55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                              Border.all(width: 1, color: Colors.grey)),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            elevation: 2,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF95A1AC),
                              size: 24,
                            ),
                            value: controller
                                .orderSetting[index]['Harga'].value,
                            borderRadius: BorderRadius.circular(8),
                            underline: const SizedBox(),
                            isExpanded: true,
                            items: controller.listHarga.map((element) {
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
                            onChanged: (String? value) => controller
                                .orderSetting[index]['Harga'](value),
                          ),
                        ),
                        const Spacer(),
                        Switch.adaptive(
                          activeColor: const Color(0xFF3978EF),
                          value: controller.orderSetting[index]["Status"].value,
                          onChanged: (value) => controller.orderSetting[index]["Status"](value),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: LugoButton(
                    textButton: 'Simpan Pengaturan',
                    textColor: Colors.white,
                    textSize: 12,
                    width: Get.width,
                    height: 60,
                    color: const Color(0xFF3978EF),
                    onTap: () {
                      // controller.serviceSetup(
                      //     controller.orderSetting[0]['Status'].value,
                      //     int.parse(controller.orderSetting[0]['Harga'].value),
                      //     controller.orderSetting[1]['Status'].value,
                      //     int.parse(controller.orderSetting[1]['Harga'].value),
                      //     controller.orderSetting[2]['Status'].value,
                      //     int.parse(controller.orderSetting[2]['Harga'].value));
                    })
              )
            ],
          )),
    );
  }
}
