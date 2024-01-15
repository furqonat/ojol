import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/balance/controller_balance.dart';
import 'package:lugo_marchant/shared/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class PageBalance extends GetView<ControllerBalance> {
  const PageBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Icon(Icons.chevron_left, size: 24, color: Colors.white),
              ),
            ),
          ),
        ),
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
                intlNumberCurrency(controller.merchant.value.wallet?.balance),
                style: GoogleFonts.readexPro(
                    fontSize: 30,
                    color: const Color(0xFF14181B),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      topUpBs(context);
                    },
                    child: const Text("Topup"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      wdBs(context);
                    },
                    child: const Text("Withdraw"),
                  )
                ],
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "ID Transaksi : ${controller.transaction[index].id}",
                          style: GoogleFonts.readexPro(
                              fontSize: 14,
                              color: const Color(0xFF14181B),
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          controller.transaction[index].createdAt,
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
                          intlNumberCurrency(
                              controller.transaction[index].amount),
                          style: GoogleFonts.readexPro(
                              fontSize: 16,
                              color: const Color(0xFF14181B),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          controller.transaction[index].status,
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

  topUpBs(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Topup Saldo",
              style: GoogleFonts.readexPro(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                autofocus: false,
                controller: controller.amountTp,
                style: GoogleFonts.readexPro(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF95A1AC),
                ),
                decoration: InputDecoration(
                  labelText: 'Jumlah',
                  labelStyle: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF95A1AC),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFF4B39EF),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFF1D2428),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                  ),
                  contentPadding: const EdgeInsets.all(24),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                controller.handleTopUp().then((value) async {
                  if (!await launchUrl(Uri.parse(value))) {
                    Fluttertoast.showToast(msg: "unable topup");
                  }
                });
              },
              child: const Text("Lanjutkan"),
            )
          ],
        );
      },
    );
  }

  wdBs(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Withdraw",
              style: GoogleFonts.readexPro(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                autofocus: false,
                controller: controller.amountTp,
                style: GoogleFonts.readexPro(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF95A1AC),
                ),
                decoration: InputDecoration(
                  labelText: 'Jumlah',
                  labelStyle: GoogleFonts.readexPro(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF95A1AC),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFF4B39EF),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(0xFF1D2428),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                  ),
                  contentPadding: const EdgeInsets.all(24),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                controller.handleWithdraw(() {
                  Get.back();
                });
              },
              child: const Text("Lanjutkan"),
            )
          ],
        );
      },
    );
  }
}
