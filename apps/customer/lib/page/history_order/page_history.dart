import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/page/history_order/controller_history.dart';

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
          style:
              GoogleFonts.readexPro(fontSize: 22, fontWeight: FontWeight.w400),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Driver',
                          style: GoogleFonts.readexPro(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3978EF),
                          ),
                        ),
                        Text(
                          '13.00',
                          style: GoogleFonts.readexPro(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      'Santoso',
                      style: GoogleFonts.readexPro(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      'B xxxx AAA',
                      style: GoogleFonts.readexPro(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text(
                      'Cash | Rp 10.000',
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
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.location_solid,
                            color: Color(0xFF3978EF)),
                        const SizedBox(width: 10),
                        Text(
                          'Jalan jalan no. 123',
                          style: GoogleFonts.readexPro(
                            fontSize: 18,
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
                      children: [
                        const Icon(CupertinoIcons.location_solid,
                            color: Colors.deepOrangeAccent),
                        const SizedBox(width: 10),
                        Text(
                          'Jalan jalan no. 123',
                          style: GoogleFonts.readexPro(
                            fontSize: 18,
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
    );
  }
}
