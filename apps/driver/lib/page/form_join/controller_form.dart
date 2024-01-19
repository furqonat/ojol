import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_driver/route/route_name.dart';
import 'package:lugo_driver/shared/preferences.dart';
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

  final partnerType = ''.obs;
  final referal = ''.obs;

  final fullName = TextEditingController();
  final completeAddress = TextEditingController();
  final phone = TextEditingController();
  final vehicle = TextEditingController();
  final vehicleBrand = TextEditingController();
  final vehicleYear = TextEditingController();
  final vehicleRn = TextEditingController();

  final viewIdCard = ''.obs;
  final viewVehicleRegistration = ''.obs;
  final viewVehicleRegistation = ''.obs;
  final viewVehicle = ''.obs;

  final idCardImageLink = ''.obs;
  final vehicleRegistrationImageLink = ''.obs;
  final drivingLicenseImageLink = ''.obs;
  final vehicleImageLink = ''.obs;

  var idCardFile = XFile('');
  var vehicleRegistrationFile = XFile('');
  var drivingLicenseFile = XFile('');
  var vehicleFile = XFile('');

  final ImagePicker picker = ImagePicker();

  final _fbAuth = FirebaseAuth.instance;

  //KTP
  getIdCardFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      viewIdCard.value = camImage.path;
      idCardFile = camImage;
      uploadIdCard();
    }
  }

  getIdCardFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      viewIdCard.value = fileImage.path;
      idCardFile = fileImage;
      uploadIdCard();
    }
  }

  uploadIdCard() async {
    String fileName = idCardFile.name;
    final path = 'user/vehicle/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      File fileToUpload = File(idCardFile.path);

      UploadTask uploadTask = ref.putFile(fileToUpload);

      uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        idCardImageLink.value = downloadURL;
        Fluttertoast.showToast(msg: 'Foto KTP berhasil di unggah');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto KTP gagal di unggah');
    }
  }

  //VehicleRegistration
  getVehicleRegistrationFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      viewVehicleRegistration.value = camImage.path;
      vehicleRegistrationFile = camImage;
      uploadVehicleRegistrationImage();
    }
  }

  getVehicleRegistrationFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      viewVehicleRegistration.value = fileImage.path;
      vehicleRegistrationFile = fileImage;
      uploadVehicleRegistrationImage();
    }
  }

  uploadVehicleRegistrationImage() async {
    String fileName = vehicleRegistrationFile.name;
    final path = 'user/vehicle/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      File fileToUpload = File(vehicleRegistrationFile.path);

      UploadTask uploadTask = ref.putFile(fileToUpload);

      uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        vehicleRegistrationImageLink.value = downloadURL;
        Fluttertoast.showToast(
            msg: 'Foto VehicleRegistration berhasil di unggah');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto VehicleRegistration gagal di unggah');
    }
  }

  //SIM
  getDrivingLicenseFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      viewVehicleRegistation.value = camImage.path;
      drivingLicenseFile = camImage;
      uploadDriverLicenseImage();
    }
  }

  getDrivingLicenseFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      viewVehicleRegistation.value = fileImage.path;
      drivingLicenseFile = fileImage;
      uploadDriverLicenseImage();
    }
  }

  uploadDriverLicenseImage() async {
    String fileName = vehicleRegistrationFile.name;
    final path = 'user/vehicle/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      File fileToUpload = File(drivingLicenseFile.path);

      UploadTask uploadTask = ref.putFile(fileToUpload);

      uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        drivingLicenseImageLink.value = downloadURL;
        Fluttertoast.showToast(msg: 'Foto SIM berhasil di unggah');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto SIM gagal di unggah');
    }
  }

  getVehicleImageFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      viewVehicle.value = camImage.path;
      vehicleFile = camImage;
      uploadVehicleImage();
    }
  }

  getVehicleImageFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      viewVehicle.value = fileImage.path;
      vehicleFile = fileImage;
      uploadVehicleImage();
    }
  }

  uploadVehicleImage() async {
    String fileName = vehicleFile.name;
    final path = 'user/vehicle/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      File fileToUpload = File(vehicleFile.path);

      UploadTask uploadTask = ref.putFile(fileToUpload);

      uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        vehicleImageLink.value = downloadURL;
        Fluttertoast.showToast(msg: 'Foto Kendaraan berhasil di unggah');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto Kendaraan gagal di unggah');
    }
  }

  Future handleApplyDriver() async {
    try {
      final token = await _fbAuth.currentUser!.getIdToken(true);
      final body = {
        "details": {
          "driver_type": partnerType.value,
          "address": completeAddress.text,
          "license_image": drivingLicenseImageLink.value,
          "id_card_image": idCardImageLink.value,
          "vehicle": {
            "create": {
              "vehicle_type": partnerType.value, // BIKE or CAR,
              "vehicle_brand": vehicleBrand.text,
              "vehicle_year": vehicleYear.text,
              "vehicle_image": vehicleImageLink.value,
              "vehicle_registration": vehicleRegistrationImageLink.value,
              "vehicle_rn": vehicleRn.text // plat nomor
            }
          }
        },
        "referal": referal.value,
        "name": fullName.text,
        "phone": _fbAuth.currentUser?.phoneNumber,
      };
      final resp = await accountClient.applyToBeDriver(
        bearerToken: "Bearer $token",
        body: body,
      );
      if (resp.message == 'OK') {
        preferences.setAlreadyJoin(true);
        Get.offAndToNamed(Routes.main);
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
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
