import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller_orderfinish.dart';

class PageOrderFinish extends GetView<ControllerOrderFinish>{
  const PageOrderFinish({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: Text(
            "Sudah Sampai",
            style: GoogleFonts.readexPro(
              color: const Color(0xFF3978EF),
              fontWeight: FontWeight.bold,
            )
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: const Image(
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/sample_food.png')
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'User name',
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'B xxxx AA',
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Mio J',
                        style: GoogleFonts.readexPro(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      AnimatedRatingStars(
                        starSize: 16,
                        readOnly: true,
                        initialRating: 3,
                        onChanged: (p0) {},
                        customEmptyIcon: Icons.star,
                        customFilledIcon: Icons.star,
                        customHalfFilledIcon: Icons.star,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: RichText(
                text: TextSpan(
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3978EF)
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'ID Transaksi'
                      ),
                      TextSpan(
                          text: ' 1234567899',
                          style: GoogleFonts.readexPro(
                              fontSize: 16,
                              color: Colors.black54
                          )
                      ),
                    ]
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: RichText(
                text: TextSpan(
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3978EF)
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'ID Order'
                      ),
                      TextSpan(
                          text: ' 1234567899',
                          style: GoogleFonts.readexPro(
                              fontSize: 16,
                              color: Colors.black54
                          )
                      ),
                    ]
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: RichText(
                text: TextSpan(
                    style: GoogleFonts.readexPro(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3978EF)
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                          text: 'Pembayaran'
                      ),
                      TextSpan(
                          text: ' | cash',
                          style: GoogleFonts.readexPro(
                              fontSize: 16,
                              color: Colors.black54
                          )
                      ),
                    ]
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 50),
            child: Text(
              'Rp 8.000',
              style: GoogleFonts.readexPro(
                fontSize: 30,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: Get.width,
              height: Get.height * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                          "Rating Driver",
                          style: GoogleFonts.readexPro(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF3978EF)
                          )
                      ),
                      AnimatedRatingStars(
                        starSize: 16,
                        initialRating: 3,
                        onChanged: (p0) {},
                        customEmptyIcon: Icons.star,
                        customFilledIcon: Icons.star,
                        customHalfFilledIcon: Icons.star,
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          fixedSize: Size(Get.width, Get.height * 0.06),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                          ),
                          backgroundColor: const Color(0xFF3978EF)
                      ),
                      child: Text(
                        "Selesai",
                        style: GoogleFonts.readexPro(
                            fontSize: 16,
                            color: Colors.white
                        ),
                      )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}