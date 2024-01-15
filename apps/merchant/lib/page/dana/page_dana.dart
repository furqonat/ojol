import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/dana/controller_dana.dart';
import 'package:lugo_marchant/shared/utils.dart';

class PageDana extends GetView<ControllerDana> {
  const PageDana({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: InkWell(
            onTap: () => Get.back(),
            child: SizedBox(
              width: 55,
              height: 55,
              child: Card(
                elevation: 0,
                color: const Color(0xFF3978EF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(
                  child:
                      Icon(Icons.chevron_left, size: 24, color: Colors.white),
                ),
              ),
            )),
        actions: [
          const Image(
              width: 80.0,
              height: 30.0,
              fit: BoxFit.contain,
              image: AssetImage("assets/images/1699744330264.png")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Obx(
                () => Text(
                  controller.phoneNumber.value,
                  style: GoogleFonts.readexPro(
                      fontSize: 16,
                      color: const Color(0xFF14181B),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text(
                  "Saldo Tersedia",
                  style: GoogleFonts.readexPro(
                      fontSize: 18,
                      color: const Color(0xFF3978EF),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Center(
              child: Text(
                intlNumberCurrency(controller.balance.value),
                style: GoogleFonts.readexPro(
                    fontSize: 30,
                    color: const Color(0xFF14181B),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Saldo tersedia",
                    style: GoogleFonts.readexPro(
                        fontSize: 18,
                        color: const Color(0xFF14181B),
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                        elevation: 2,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF95A1AC),
                          size: 24,
                        ),
                        value: controller.orderValue.value,
                        borderRadius: BorderRadius.circular(8),
                        underline: const SizedBox(),
                        items: controller.orderList.map((element) {
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
                        onChanged: (String? value) {
                          controller.orderValue(value);
                          if (value == "Bulan Ini") {
                            controller.handleGetTrx("month");
                          } else if (value == "Minggu Ini") {
                            controller.handleGetTrx("week");
                          } else {
                            controller.handleGetTrx("day");
                          }
                        }),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.transaction.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    leading: SizedBox(
                      width: 55,
                      height: 55,
                      child: Card(
                        elevation: 0,
                        color: const Color(0xFF3978EF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        child: const Center(
                          child: Icon(Icons.attach_money_rounded,
                              size: 24, color: Colors.white),
                        ),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          controller.transaction[index].trxType,
                          style: GoogleFonts.readexPro(
                              fontSize: 16,
                              color: const Color(0xFF14181B),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "ID Transaksi 0812345678",
                          style: GoogleFonts.readexPro(
                              fontSize: 14,
                              color: const Color(0xFF14181B),
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "11 November 2023 - 07.00",
                          style: GoogleFonts.readexPro(
                              fontSize: 14,
                              color: const Color(0xFF14181B),
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Rp 20.000",
                          style: GoogleFonts.readexPro(
                              fontSize: 16,
                              color: const Color(0xFF14181B),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Berhasil",
                          style: GoogleFonts.readexPro(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xFF3978EF),
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
      ),
    );
  }
}
