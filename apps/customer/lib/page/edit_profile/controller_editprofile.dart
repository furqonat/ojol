import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_customer/page/edit_profile/api_editprofile.dart';
import 'package:lugo_customer/route/route_name.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

enum Status { idle, loading, success, failed }

class ControllerEditProfile extends GetxController {
  final ApiEditProfile api;
  ControllerEditProfile({required this.api});

  final firebase = FirebaseAuth.instance;

  var loading = Status.idle.obs;

  final formkeyEditUser = GlobalKey<FormState>();

  var edtName = TextEditingController();
  var edtEmail = TextEditingController();
  var edtPhone = TextEditingController();
  var edtOTP = TextEditingController();

  var phoneCheck = ''.obs;

  var avatar = ''.obs;

  var photoProfile = ''.obs;

  var imgPreview = ''.obs;
  XFile? file;

  final ImagePicker picker = ImagePicker();

  getFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      imgPreview.value = camImage.path;
      file = camImage;
      uploadImage();
    }
  }

  getFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      imgPreview.value = fileImage.path;
      file = fileImage;
      uploadImage();
    }
  }

  uploadImage() async {
    if (file == null) {
      log('Error: File is null.');
      return;
    }

    String fileName = file!.name;
    final path = 'user/profile/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      File fileToUpload = File(file!.path);

      UploadTask uploadTask = ref.putFile(fileToUpload);

      uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        avatar.value = downloadURL;
        Fluttertoast.showToast(msg: 'Foto profil berhasil di unggah');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto profil gagal di unggah');
    }
  }

  updateUser() async {
    try {
      loading(Status.loading);
      var firebaseCurrentToken = await firebase.currentUser?.getIdToken();
      var r = await api.editUser(
          name: edtName.text,
          email: edtEmail.text,
          phone: '+62${edtPhone.text}',
          avatar: avatar.value == '' ? photoProfile.value : avatar.value,
          token: firebaseCurrentToken!);
      if (r['message'] == 'OK') {
        Fluttertoast.showToast(msg: 'Data anda sudah berubah');
        Get.offAllNamed(Routes.home, arguments: 4);
        loading(Status.success);
      } else {
        Fluttertoast.showToast(msg: 'Data anda tidak dapat dirubah');
        loading(Status.failed);
      }
    } catch (e, stackTrace) {
      loading(Status.failed);
      log('$e');
      log('$stackTrace');
    }
  }

  //kalau nomor hp beda
  firebasePhoneVerification(BuildContext context) async {
    try {
      await firebase.verifyPhoneNumber(
        phoneNumber: '+62${edtPhone.text}',
        verificationFailed: (error) {},
        codeAutoRetrievalTimeout: (verificationId) {},
        verificationCompleted: (phoneAuthCredential) {},
        codeSent: (verificationId, forceResendingToken) async {
          showModalBottomSheet(
            context: context,
            isDismissible: false,
            constraints:
                BoxConstraints.expand(width: Get.width, height: Get.height),
            builder: (context) => Column(
              children: [
                Text(
                  "PIN OTP",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Kode OTP sudah kami kirimkan menuju nomor ${edtPhone.text}\nJangan sebarkan kode ini kepada siapapun.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: Colors.black54),
                  ),
                ),
                PinCodeTextField(
                  length: 6,
                  autoFocus: false,
                  hintCharacter: '-',
                  appContext: context,
                  enableActiveFill: false,
                  keyboardType: TextInputType.number,
                  controller: edtOTP,
                  textStyle: GoogleFonts.readexPro(
                    fontSize: 12,
                    color: const Color(0xFF4B39EF),
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  pinTheme: PinTheme(
                    fieldHeight: 50.0,
                    fieldWidth: 50.0,
                    borderWidth: 2.0,
                    borderRadius: BorderRadius.circular(12.0),
                    shape: PinCodeFieldShape.box,
                    activeColor: const Color(0xFF4B39EF),
                    inactiveColor: const Color(0xFFF1F4F8),
                    selectedColor: const Color(0xFF95A1AC),
                    activeFillColor: const Color(0xFF4B39EF),
                    inactiveFillColor: const Color(0xFFF1F4F8),
                    selectedFillColor: const Color(0xFF95A1AC),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () async {
                      final credential = PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: edtOTP.text);
                      firebase.currentUser
                          ?.updatePhoneNumber(credential)
                          .then((value) async {
                        var newToken = await firebase.currentUser?.getIdToken();

                        final pattern = RegExp('.{1,800}');
                        pattern
                            .allMatches(newToken!)
                            .forEach((match) => debugPrint(match.group(0)));

                        updateUser();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        fixedSize: Size(Get.width * 0.5, Get.height * 0.07),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        backgroundColor: const Color(0xFF3978EF)),
                    child: Text(
                      "Lanhjutkan",
                      style: GoogleFonts.readexPro(
                          fontSize: 16, color: Colors.white),
                    ))
              ],
            ),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    }
  }

  @override
  void onInit() {
    edtName.text = Get.arguments['name'];
    edtEmail.text = Get.arguments['email'];
    photoProfile.value = Get.arguments['avatar'];

    var phone = Get.arguments['phone'].toString().replaceFirst('+62', '');

    edtPhone.text = phone;
    phoneCheck.value = phone;

    super.onInit();
  }

  @override
  void dispose() {
    edtName.dispose();
    edtPhone.dispose();
    edtEmail.dispose();
    super.dispose();
  }
}
