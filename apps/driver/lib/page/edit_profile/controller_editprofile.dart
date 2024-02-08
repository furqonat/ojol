import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_driver/response/driver.dart';
import 'package:rest_client/account_client.dart';
import '../../route/route_name.dart';
import '../../shared/query_builder.dart';

class ControllerEditProfile extends GetxController{
  final AccountClient accountClient;

  ControllerEditProfile({required this.accountClient});

  var edtAddress = TextEditingController();
  var edtBrand = TextEditingController();
  var edtYear = TextEditingController();
  var edtRegis = TextEditingController();

  final selection = ["BIKE", "CAR"];

  final selectChip = 'BIKE'.obs;

  var viewKTP = ''.obs;
  var viewSIM = ''.obs;
  var viewKendaraan = ''.obs;

  var uploadKTP = ''.obs;
  var uploadSIM = ''.obs;
  var uploadKendaraan = ''.obs;

  late XFile fileKTP = XFile(''), fileSIM = XFile(''), fileKendaraan = XFile('');

  final ImagePicker picker = ImagePicker();

  final FirebaseAuth firebase = FirebaseAuth.instance;

  Rx<Driver> driver = Driver().obs;

  handleSelectedChip(bool selected) {
    selectChip.value = selected && selectChip.value == 'BIKE'
        ? 'CAR'
        : !selected && selectChip.value == 'CAR'
        ? 'CAR'
        : 'BIKE';
  }

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
    String fileName = fileSIM.name;
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

  getDriver()async{
    try{
      var token = await firebase.currentUser?.getIdToken(true);
      final query = QueryBuilder()
        ..addQuery("id", "true")
        ..addQuery("driver_wallet", "true");
      var resp = await accountClient.getDriver(bearerToken: token!, queries: query.toMap());
      driver.value = Driver.fromJson(resp);
    }catch(e, stackTrace){
      log('$e');
      log('$stackTrace');
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

  editUser()async{
    try{
      var token = await firebase.currentUser?.getIdToken(true);
      var resp = await accountClient.updateApplyToBeDriver(
          bearerToken: token!,
          body: {
            "address": edtAddress.text,
            "license_image": uploadKendaraan.value,
            "id_card_image": uploadKTP.value,
            "vehicle": {
              "update": {
                "data": {
                  "vehicle_type": selectChip.value,
                  "vehicle_brand": edtBrand.text,
                  "vehicle_year": edtYear.text,
                  "vehicle_image": uploadKendaraan.value,
                  "vehicle_registration": edtRegis.text
                },
                "where": {"driver_details_id": driver.value.details?.id}
              }
            }
          });
      if(resp.message == 'OK'){
        Get.offAllNamed(Routes.main, arguments: 4);
      }
    }catch(e, stackTrace){
      log('$e');
      log('$stackTrace');
    }
  }

  @override
  void onInit() {
    getDriver();
    super.onInit();
  }
}
