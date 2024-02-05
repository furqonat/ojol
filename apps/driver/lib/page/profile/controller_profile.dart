import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../api/local_serivce.dart';
import '../../response/user.dart';
import 'api_profile.dart';

enum Status { idle, loading, success, failed }

class ControllerProfile extends GetxController {
  final ApiProfile api;
  final LocalService localService;
  ControllerProfile({required this.api, required this.localService});

  var loading = Status.idle.obs;

  final firebase = FirebaseAuth.instance;

  var orderSetting = false.obs;
  final cUser = UserResponse().obs;

  userHelp(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: Get.width,
          height: Get.height * 0.35,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Text(
                    textAlign: TextAlign.center,
                    'Kontak & Informasi\nBantuan',
                    style: GoogleFonts.readexPro(
                      fontSize: 24,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          style: GoogleFonts.readexPro(
                              fontSize: 14, color: Colors.black87),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Whatsapp ',
                            ),
                            TextSpan(
                                text: '081234567899',
                                style: GoogleFonts.readexPro(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                )),
                          ]),
                    ),
                    const Spacer(),
                    const Icon(Icons.phone_rounded, color: Colors.green)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          style: GoogleFonts.readexPro(
                              fontSize: 14, color: Colors.black87),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Email ',
                            ),
                            TextSpan(
                                text: 'admin@email.com',
                                style: GoogleFonts.readexPro(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                )),
                          ]),
                    ),
                    const Spacer(),
                    const Icon(Icons.email_rounded, color: Colors.red)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getUser() async {
    try {
      loading(Status.loading);
      var firebaseToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      var r = await api.userDetail(token: firebaseToken!);
      log("HI => $r");
      if (r["id"] != "" || r["id"] != null) {
        var user = UserResponse.fromJson(r);
        cUser.value = user;
        await localService.setUser(user: user.toJson());
        loading(Status.success);
      } else {
        Fluttertoast.showToast(msg: 'Something wrong');
        loading(Status.failed);
      }
    } catch (e, stackTrace) {
      loading(Status.failed);
      log('$e');
      log('$stackTrace');
    }
  }

  @override
  void onInit() async {
    getUser();
    super.onInit();
  }
}
