import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_marchant/api/local_service.dart';
import 'package:lugo_marchant/route/route_name.dart';
import 'package:phone_number/phone_number.dart';

import 'api.dart';

enum VerificationState {
  phoneOnly,
  full,
}

enum UploadStatus {
  idle,
  uploading,
}

enum ImageType {
  idCard,
  shopImage1,
  shopImage2,
}

class PhoneVerificationStatus {
  final bool status;
  final String message;

  PhoneVerificationStatus({required this.status, required this.message});
}

class VerificationController extends GetxController {
  VerificationController({required this.apiService});
  final ApiService apiService;
  final formPhoneVerification = GlobalKey<FormState>();

  // verification phone number
  final phoneNumber = TextEditingController();
  final smsCode = TextEditingController();

  // verification details
  final fullName = TextEditingController();
  final shopName = TextEditingController();
  final address = TextEditingController();
  final idCardImage = ''.obs;
  final shopImages1 = ''.obs;
  final shopImages2 = ''.obs;
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;

  final imagePicker = ImagePicker();
  final uploadStatus = UploadStatus.idle.obs;

  final verificationState = Get.parameters['state'];
  final activeStep = 0.obs;
  final verificationStatus =
      PhoneVerificationStatus(status: false, message: "").obs;

  final _fbAuth = FirebaseAuth.instance;

  void handleActiveStep(int index) {
    activeStep.value = index;
  }

  void handleCaptureIdCardImage() async {
    final cameraImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    uploadImage(cameraImage, ImageType.idCard);
  }

  void handlePickShopImage1() async {
    final image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    uploadImage(image, ImageType.shopImage1);
  }

  void handlePickShopImage2() async {
    final image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    uploadImage(image, ImageType.shopImage2);
  }

  uploadImage(XFile? file, ImageType imageType) async {
    uploadStatus.value = UploadStatus.uploading;
    if (file == null) {
      Fluttertoast.showToast(msg: "No image are capture");
      uploadStatus.value = UploadStatus.idle;
      return;
    }
    String fileName = file.name;
    String cloudPath = "/verification/merchant/$fileName";
    Reference cloudRef = FirebaseStorage.instance.ref().child(cloudPath);
    File currentFile = File(file.path);
    UploadTask uploadTask = cloudRef.putFile(currentFile);
    uploadTask.whenComplete(() async {
      uploadStatus.value = UploadStatus.idle;
      String downloadUrl = await cloudRef.getDownloadURL();
      if (imageType == ImageType.idCard) {
        idCardImage.value = downloadUrl;
      }
      if (imageType == ImageType.shopImage1) {
        shopImages1.value = downloadUrl;
      }
      if (imageType == ImageType.shopImage2) {
        shopImages2.value = downloadUrl;
      }
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void pickAddress() async {
    _determinePosition().then((value) async {
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      final places = await placemarkFromCoordinates(
        value.latitude,
        value.longitude,
      );
      final place = places.first;
      address.value = TextEditingValue(
        text:
            "${place.subLocality}, ${place.street}, ${place.name}, ${place.postalCode}",
      );
    }).catchError((error) {
      AppSettings.openAppSettings(type: AppSettingsType.location);
    });
  }

  void handleSaveDetail() async {
    final body = {
      "name": fullName.value.text,
      "phone": _fbAuth.currentUser?.phoneNumber,
      "details": {
        "create": {
          "id_card_image": idCardImage.value,
          "address": address.value.text,
          "latitude": latitude.value,
          "longitude": longitude.value,
          "name": shopName.value.text,
          "images": {
            "createMany": {
              "data": [
                {"link": shopImages1.value},
                {"link": shopImages2.value}
              ]
            }
          }
        }
      }
    };
    final token = await _fbAuth.currentUser?.getIdToken(true);
    final result = await apiService.applyMerchant(body: body, token: token);
    if (result.message == 'OK') {
      LocalService().setIsLogin(isLogin: true);
      LocalService().setInVerification(false);
      Get.offAllNamed(Routes.bottomNav);
    } else {
      Fluttertoast.showToast(msg: "unable apply merchant");
    }
  }

  Future<void> handleVerificationPhone() async {
    const regionInfo = RegionInfo(name: "Indonesia", code: "ID", prefix: 62);
    final phone = await PhoneNumberUtil().parse(
      phoneNumber.text,
      regionCode: regionInfo.code,
    );
    _fbAuth.verifyPhoneNumber(
      phoneNumber: phone.e164,
      verificationCompleted: (phoneAuthCredential) {
        if (verificationState == "1") {
          _fbAuth.currentUser
              ?.linkWithCredential(phoneAuthCredential)
              .then((value) {
            verificationStatus.value = PhoneVerificationStatus(
              status: true,
              message: "OK",
            );
          }).catchError((error) {
            verificationStatus.value = PhoneVerificationStatus(
              status: false,
              message: error.code,
            );
          });
        } else {
          _fbAuth.currentUser
              ?.reauthenticateWithCredential(phoneAuthCredential)
              .then((value) {
            verificationStatus.value = PhoneVerificationStatus(
              status: true,
              message: "OK",
            );
          }).catchError((error) {
            verificationStatus.value = PhoneVerificationStatus(
              status: false,
              message: error.code,
            );
          });
        }
      },
      verificationFailed: (error) {
        verificationStatus.value = PhoneVerificationStatus(
          status: false,
          message: error.code,
        );
      },
      codeSent: (verificationId, forceResendingToken) {
        final credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode.text);
        if (verificationState == "1") {
          _fbAuth.currentUser?.linkWithCredential(credential).then((value) {
            verificationStatus.value = PhoneVerificationStatus(
              status: true,
              message: "OK",
            );
          }).catchError((error) {
            verificationStatus.value = PhoneVerificationStatus(
              status: false,
              message: error.code,
            );
          });
        } else {
          _fbAuth.currentUser
              ?.reauthenticateWithCredential(credential)
              .then((value) {
            verificationStatus.value = PhoneVerificationStatus(
              status: true,
              message: "OK",
            );
          }).catchError((error) {
            verificationStatus.value = PhoneVerificationStatus(
              status: false,
              message: error.code,
            );
          });
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  void onInit() {
    final phone = _fbAuth.currentUser?.phoneNumber;
    if (phone != null) {
      phoneNumber.value = TextEditingValue(text: phone.replaceAll(r'+62', ''));
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _determinePosition().then((value) async {
      latitude.value = value.latitude;
      longitude.value = value.longitude;
      final places = await placemarkFromCoordinates(
        value.latitude,
        value.longitude,
      );
      final place = places.first;
      address.value = TextEditingValue(
        text:
            "${place.subLocality}, ${place.street}, ${place.name}, ${place.postalCode}",
      );
    }).catchError((error) {
      AppSettings.openAppSettings(type: AppSettingsType.location);
    });
  }
}
