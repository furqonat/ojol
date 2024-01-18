import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_driver/api/local_serivce.dart';
import 'package:lugo_driver/route/route_name.dart';
import 'package:lugo_driver/shared/preferences.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rest_client/account_client.dart';
import 'api_form.dart';

class ControllerFormJoin extends GetxController {
  final ApiFormJoin api;
  final Preferences preferences;
  final AccountClient accountClient;
  ControllerFormJoin({
    required this.api,
    required this.preferences,
    required this.accountClient,
  });

  final formkeyAuthRegister = GlobalKey<FormState>();

  var partnerType = ''.obs;
  var referal = ''.obs;

  var fullName = TextEditingController();
  var completeAddress = TextEditingController();
  var phone = TextEditingController();
  var vehicle = TextEditingController();
  var vehicleBrand = TextEditingController();
  var vehicleYear = TextEditingController();
  var vehicleRn = TextEditingController();

  var edtEmail = TextEditingController();
  var edtPassword = TextEditingController();

  var edtOTP = TextEditingController();

  var showPassword = true.obs;

  var viewKTP = ''.obs;
  var viewSTNK = ''.obs;
  var viewSIM = ''.obs;
  var viewKendaraan = ''.obs;

  var uploadKTP = ''.obs;
  var uploadSTNK = ''.obs;
  var uploadSIM = ''.obs;
  var uploadKendaraan = ''.obs;

  late XFile fileKTP = XFile(''),
      fileSTNK = XFile(''),
      fileSIM = XFile(''),
      fileKendaraan = XFile('');

  final ImagePicker picker = ImagePicker();

  final firebase = FirebaseAuth.instance;

  //KTP
  getKTPFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      viewKTP.value = camImage.path;
      fileKTP = camImage;
      uploadKTPImage();
    }
  }

  getKTPFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      viewKTP.value = fileImage.path;
      fileKTP = fileImage;
      uploadKTPImage();
    }
  }

  uploadKTPImage() async {
    String fileName = fileKTP.name;
    final path = 'user/vehicle/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      File fileToUpload = File(fileKTP.path);

      UploadTask uploadTask = ref.putFile(fileToUpload);

      uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        uploadKTP.value = downloadURL;
        Fluttertoast.showToast(msg: 'Foto KTP berhasil di unggah');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto KTP gagal di unggah');
    }
  }

  //STNK
  getSTNKFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      viewSTNK.value = camImage.path;
      fileSTNK = camImage;
      uploadSTNKImage();
    }
  }

  getSTNKFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      viewSTNK.value = fileImage.path;
      fileSTNK = fileImage;
      uploadSTNKImage();
    }
  }

  uploadSTNKImage() async {
    String fileName = fileSTNK.name;
    final path = 'user/vehicle/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      File fileToUpload = File(fileSTNK.path);

      UploadTask uploadTask = ref.putFile(fileToUpload);

      uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        uploadSTNK.value = downloadURL;
        Fluttertoast.showToast(msg: 'Foto STNK berhasil di unggah');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto STNK gagal di unggah');
    }
  }

  //SIM
  getSIMFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      viewSIM.value = camImage.path;
      fileSIM = camImage;
      uploadSIMImage();
    }
  }

  getSIMFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      viewSIM.value = fileImage.path;
      fileSIM = fileImage;
      uploadSIMImage();
    }
  }

  uploadSIMImage() async {
    String fileName = fileSTNK.name;
    final path = 'user/vehicle/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      File fileToUpload = File(fileSIM.path);

      UploadTask uploadTask = ref.putFile(fileToUpload);

      uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        uploadSIM.value = downloadURL;
        Fluttertoast.showToast(msg: 'Foto SIM berhasil di unggah');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto SIM gagal di unggah');
    }
  }

  //Kendaraan
  getKendaraanFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      viewKendaraan.value = camImage.path;
      fileKendaraan = camImage;
      uploadKendaraanImage();
    }
  }

  getKendaraanFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      viewKendaraan.value = fileImage.path;
      fileKendaraan = fileImage;
      uploadKendaraanImage();
    }
  }

  uploadKendaraanImage() async {
    String fileName = fileKendaraan.name;
    final path = 'user/vehicle/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      File fileToUpload = File(fileKendaraan.path);

      UploadTask uploadTask = ref.putFile(fileToUpload);

      uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        uploadKendaraan.value = downloadURL;
        Fluttertoast.showToast(msg: 'Foto Kendaraan berhasil di unggah');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto Kendaraan gagal di unggah');
    }
  }

  //Register with firebase register
  firebaseRegister(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: edtEmail.text, password: edtPassword.text);
      firebasePhoneVerification(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'The email address is already in use by another account.') {
        Fluttertoast.showToast(msg: 'This email already use by another user');
      }
    }
  }

  firebasePhoneVerification(BuildContext context) async {
    try {
      await firebase.verifyPhoneNumber(
        phoneNumber: '+62${phone.text}',
        verificationFailed: (error) {},
        timeout: const Duration(minutes: 2),
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
                    "Kode OTP sudah kami kirimkan menuju nomor ${phone.text}\nJangan sebarkan kode ini kepada siapapun.",
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
                        var useToken = await firebase.currentUser?.getIdToken();
                        sendToken(context, useToken!);
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

  sendToken(BuildContext context, String token) async {
    try {
      var r = await api.sendToken(sample: '', token: token);
      if (r["message"] == "OK") {
        joinLugo();
      } else {
        log('save token gagal');
      }
    } catch (e, stackTrace) {
      log(e.toString());
      log(stackTrace.toString());
    }
  }

  joinLugo() async {
    try {
      final token = await firebase.currentUser!.getIdToken(true);

      // final pattern = RegExp('.{1,800}');
      // pattern.allMatches(token!).forEach((match) => debugPrint(match.group(0)));
      final body = {
        "details": {
          "driver_type": partnerType.value,
          "address": completeAddress,
          "license_image": uploadSIM.value,
          "id_card_image": uploadKTP.value,
          "vehicle": {
            "create": {
              "vehicle_type": partnerType.value, // BIKE or CAR,
              "vehicle_brand": vehicleBrand.text,
              "vehicle_year": vehicleYear.text,
              "vehicle_image": uploadKendaraan.value,
              "vehicle_registration": uploadSTNK.value, // FOTO stnk
              "vehicle_rn": vehicleRn.text // plat nomor
            }
          }
        },
        "referal": referal,
        "name": fullName.text,
      };
      final resp = await accountClient.applyToBeDriver(
        bearerToken: "Bearer $token",
        body: body,
      );
      if (resp.message == 'OK') {
        Get.offAndToNamed(Routes.main);
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
  }

  getFirebasetoken() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.currentUser?.getIdToken(true);
      if (userCredential != null) {
        await LocalService().setIsLogin(isLogin: true);
        Get.offAllNamed(Routes.main);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-custom-token":
          log("The supplied token is not a Firebase custom auth token.");
          break;
        case "custom-token-mismatch":
          log("The supplied token is for a different Firebase project.");
          break;
        default:
          log("Unkown error.");
      }
    }
  }

  @override
  void dispose() {
    fullName.dispose();
    completeAddress.dispose();
    phone.dispose();
    vehicle.dispose();
    vehicleBrand.dispose();
    vehicleYear.dispose();
    vehicleRn.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    partnerType.value = preferences.getPatnerType();
    referal.value = preferences.getReferal();
    super.onInit();
  }
}
