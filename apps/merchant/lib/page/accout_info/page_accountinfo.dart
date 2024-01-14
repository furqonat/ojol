import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lugo_marchant/page/accout_info/controller_accountinfo.dart';
import 'package:lugo_marchant/shared/custom_widget/lugo_btn.dart';

class PageAccountInfo extends GetView<ControllerAccountInfo> {
  const PageAccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Card(
            elevation: 0,
            color: const Color(0xFF3978EF),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Obx(
            () => GestureDetector(
              onTap: () {
                controller.handlePickImageFromGallery().then((value) {});
              },
              child: Image.network(
                controller.avatar.value,
                width: Get.width,
                height: Get.height,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image(
                    image: const AssetImage('assets/images/person.png'),
                    width: Get.width,
                    height: Get.height,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          DraggableScrollableSheet(
            maxChildSize: 0.8,
            minChildSize: 0.5,
            initialChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Obx(() => Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: TextFormField(
                              autofocus: false,
                              controller: controller.fullName,
                              style: GoogleFonts.readexPro(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xFF95A1AC),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Nama Lengkap',
                                labelStyle: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xFF95A1AC),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xFF4B39EF))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xFF1D2428))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.red)),
                                contentPadding: const EdgeInsets.all(24),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: TextFormField(
                              autofocus: false,
                              controller: controller.address,
                              style: GoogleFonts.readexPro(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xFF95A1AC),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Alamat Lengkap',
                                labelStyle: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xFF95A1AC),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xFF4B39EF))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xFF1D2428))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.red)),
                                contentPadding: const EdgeInsets.all(24),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: TextFormField(
                              enabled: false,
                              autofocus: false,
                              keyboardType: TextInputType.phone,
                              controller: controller.phone,
                              style: GoogleFonts.readexPro(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xFF95A1AC),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Nomor Ponsel',
                                labelStyle: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xFF95A1AC),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xFF4B39EF))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xFF1D2428))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.red)),
                                contentPadding: const EdgeInsets.all(24),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: TextFormField(
                              enabled: false,
                              autofocus: false,
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.email,
                              style: GoogleFonts.readexPro(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: const Color(0xFF95A1AC),
                              ),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: GoogleFonts.readexPro(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xFF95A1AC),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xFF4B39EF))),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Color(0xFF1D2428))),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.red)),
                                contentPadding: const EdgeInsets.all(24),
                              ),
                            ),
                          ),
                          ...controller.shopImages.map(
                            (e) {
                              return Container(
                                width: Get.width,
                                height: Get.height * 0.25,
                                margin:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(12)),
                                alignment: Alignment.center,
                                child: Image.network(
                                  e,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                          Container(
                            width: Get.width,
                            height: Get.height * 0.25,
                            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12)),
                            alignment: Alignment.center,
                            child: GoogleMap(
                              mapType: MapType.terrain,
                              zoomControlsEnabled: true,
                              zoomGesturesEnabled: true,
                              initialCameraPosition: const CameraPosition(
                                  zoom: 15,
                                  target: LatLng(-7.8032485, 110.3336448)),
                              onTap: (argument) =>
                                  controller.onMapTap(argument),
                              markers: controller.marker.value != null
                                  ? <Marker>{controller.marker.value!}
                                  : {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: LugoButton(
                                textButton: "Simpan Profile",
                                textColor: Colors.white,
                                textSize: 12,
                                width: Get.width * 0.45,
                                height: Get.height * 0.07,
                                color: const Color(0xFF3978EF),
                                onTap: () {
                                  controller.handleUpdateUser().then((value) {
                                    Get.back();
                                  }).catchError((error) {
                                    Fluttertoast.showToast(
                                      msg: "unable update user",
                                    );
                                  });
                                }),
                          )
                        ],
                      )),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
