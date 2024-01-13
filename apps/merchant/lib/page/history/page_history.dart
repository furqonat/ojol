import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_marchant/page/history/controller_history.dart';

class PageHistory extends GetView<ControllerHistory> {
  const PageHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Hari ini',
          style: GoogleFonts.readexPro(
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
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
      body: Column(
        children: [
          Expanded(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'ID Order | 123xxxxx',
                              style: GoogleFonts.readexPro(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AnimatedRatingStars(
                              starSize: 16,
                              readOnly: true,
                              initialRating: 5,
                              onChanged: (p0) {},
                              customEmptyIcon: Icons.star_rounded,
                              customFilledIcon: Icons.star_rounded,
                              customHalfFilledIcon: Icons.star_rounded,
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Nama Customer',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Santoso',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Nama Driver',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Mulyono',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Plat Nomor',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'B 1234 AB',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Kendaraan',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Mio J',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Ayam geprek',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'Rp 40.000',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '2x',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Ayam goreng',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'Rp 20.000',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '2x',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Ayam geprek',
                              style: GoogleFonts.readexPro(
                                color: Colors.deepOrange,
                              ),
                            ),
                            Text(
                              'Rp 12.000',
                              style: GoogleFonts.readexPro(
                                color: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'PPN',
                              style: GoogleFonts.readexPro(
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              'Rp 0',
                              style: GoogleFonts.readexPro(
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Potongan jasa',
                              style: GoogleFonts.readexPro(
                                color: const Color(0xFF3978EF),
                              ),
                            ),
                            Text(
                              'Rp 0',
                              style: GoogleFonts.readexPro(
                                color: const Color(0xFF3978EF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Total',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rp 10.000',
                              style: GoogleFonts.readexPro(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
