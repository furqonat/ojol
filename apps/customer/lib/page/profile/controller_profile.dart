import 'dart:developer';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lugo_customer/api/local_service.dart';
import 'package:lugo_customer/page/profile/api_profile.dart';
import 'package:lugo_customer/response/user.dart';
import 'package:lugo_customer/shared/controller/controller_user.dart';
import 'package:url_launcher/url_launcher.dart';

enum Status { idle, loading, success, failed }

class ControllerProfile extends GetxController{
  final ApiProfile api;
  ControllerProfile({required this.api});

  var loading = Status.idle.obs;

  ControllerUser controllerUser = Get.find<ControllerUser>();

  final firebase = FirebaseAuth.instance;

  getUser()async{
    try{
      loading(Status.loading);
      var firebaseToken = await FirebaseAuth.instance.currentUser?.getIdToken();
      var r = await api.userDetail(token: firebaseToken!);
      if(r["id"] != "" || r["id"] != null){
        var user = UserResponse.fromJson(r);
        controllerUser.user.value = user;
        await LocalService().setUser(user: user.toJson());
        loading(Status.success);
      }else{
        Fluttertoast.showToast(msg: 'Something wrong');
        loading(Status.failed);
      }
    }catch(e, stackTrace){
      loading(Status.failed);
      log('$e');
      log('$stackTrace');
    }
  }

  launchWhatsApp() async {
    String phoneNumber = '+6282324640007';
    String url = 'https://wa.me/$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication
      );
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  giveUsRate(BuildContext context){
    return showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
          ),
          title: Text(
              'Rate Us',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              )
          ),
          content: SizedBox(
            width: Get.width,
            height: Get.height * 0.25,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          width: 1,
                          color: Colors.grey
                      )
                  ),
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    maxLines: 5,
                    autofocus: false,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                      hintText: 'Tell us what you think',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      )
                    ),
                  ),
                ),
                AnimatedRatingStars(
                    starSize: 40,
                    onChanged: (p0) {},
                    customFilledIcon: Icons.star_rounded,
                    customHalfFilledIcon: Icons.star_rounded,
                    customEmptyIcon: Icons.star_rounded
                )
              ],
            ),
          ),
          actions: [
            OutlinedButton(
                onPressed: (){},
                child: Text(
                    'Rate',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )
                )
            )
          ],
        ),
    );
  }

  @override
  void onInit() async {
    getUser();
    super.onInit();
  }

}