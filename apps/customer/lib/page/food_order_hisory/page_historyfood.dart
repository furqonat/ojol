import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/food_order_hisory/controller_historyfood.dart';
import 'package:flutter/cupertino.dart';

class PageHistoryFood extends GetView<ControllerHistoryFood> {
  const PageHistoryFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: SizedBox(
            width: 50,
            height: 50,
            child: InkWell(
              onTap: () => Get.back(),
              child: Card(
                elevation: 0,
                color: const Color(0xFF3978EF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(Icons.chevron_left_outlined,
                    color: Colors.white),
              ),
            ),
          ),
          title: Text(
            'Hari ini',
            style: GoogleFonts.readexPro(
                fontSize: 22, fontWeight: FontWeight.w400),
          ),
          actions: [
            SizedBox(
              width: 50,
              height: 50,
              child: InkWell(
                child: Card(
                  elevation: 0,
                  color: const Color(0xFF3978EF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child:
                      const Icon(Icons.date_range_rounded, color: Colors.white),
                ),
              ),
            )
          ],
        ),
        body: Expanded(
            child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: SizedBox(
              width: Get.width,
              child: Card(
                elevation: 5,
                surfaceTintColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Text(
                        'Detail Pesanan',
                        style: GoogleFonts.readexPro(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: RichText(
                        text: TextSpan(
                            style: GoogleFonts.readexPro(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3978EF),
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'ID Transaksi ',
                              ),
                              TextSpan(
                                  text: '123xxxxx',
                                  style: GoogleFonts.readexPro(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: RichText(
                        text: TextSpan(
                            style: GoogleFonts.readexPro(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3978EF),
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'ID Order ',
                              ),
                              TextSpan(
                                  text: '123xxxxx',
                                  style: GoogleFonts.readexPro(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(
                              size: 16,
                              Icons.fastfood_rounded,
                              color: const Color(0xFF3978EF)),
                          const SizedBox(width: 5),
                          Text(
                            'Jalan jalan no. 123',
                            style: GoogleFonts.readexPro(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: SizedBox(
                          width: Get.width,
                          height: Get.height * 0.2,
                          child: ListView.builder(
                            itemCount: 10,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: const Image(
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/images/sample_food.png')),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Nama Item",
                                              style: GoogleFonts.readexPro(
                                                fontSize: 16,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "Rp 10.000",
                                              style: GoogleFonts.readexPro(
                                                fontSize: 12,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "1X",
                                                style: GoogleFonts.readexPro(
                                                  fontSize: 12,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Subtotal",
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rp 0",
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Subtotal Kirim",
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rp 0",
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Diskon",
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rp 0",
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Total Pembayaran",
                                style: GoogleFonts.readexPro(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Rp 0",
                                style: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  fixedSize:
                                      Size(Get.width * 0.3, Get.height * 0.03),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: const Color(0xFF3978EF)),
                              child: Text(
                                "Pesan Lagi",
                                style: GoogleFonts.readexPro(
                                    fontSize: 12, color: Colors.white),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
