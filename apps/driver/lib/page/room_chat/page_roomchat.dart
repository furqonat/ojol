import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../route/route_name.dart';
import 'binding_roomchat.dart';

class PageRoomChat extends GetView<ControllerRoomChat>{
  const PageRoomChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 0),
            child: TextFormField(
              autofocus: false,
              controller: controller.edtSearch,
              decoration: InputDecoration(
                hintText: 'Cari...',
                prefixIcon: const Icon(Icons.search_rounded, size: 20, color: Colors.grey),
                hintStyle: GoogleFonts.readexPro(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF95A1AC),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF4B39EF)
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                        width: 1,
                        color: Colors.grey
                    )
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                        width: 1,
                        color: Color(0xFF1D2428)
                    )
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                        width: 1,
                        color: Colors.red
                    )
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: ()=> Get.toNamed(Routes.chat),
                  child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: const Icon(Icons.person_rounded, size: 30, color: Colors.black54),
                      ),
                    ),
                    title: Text(
                      "Username",
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Hello World . Hello Word",
                      style: GoogleFonts.readexPro(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}