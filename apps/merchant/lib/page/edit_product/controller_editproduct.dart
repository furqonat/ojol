import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_marchant/page/edit_product/api_editproduct.dart';

class ControllerEditProduct extends GetxController{
  final ApiEditProduct api;
  ControllerEditProduct ({required this.api});

  var edtName = TextEditingController();
  var edtDescription = TextEditingController();
  var image = ''.obs;
  var imagePriview = ''.obs;
  XFile? file;
  var edtPrice = TextEditingController();
  var status = false.obs;

  final ImagePicker picker = ImagePicker();

  final firebase = FirebaseAuth.instance;

  getFromCamera() async {
    final XFile? camImage = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      imagePriview.value = camImage.path;
      file = camImage;
      uploadImage();
    }
  }

  getFromFile() async {
    final XFile? fileImage =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      imagePriview.value = fileImage.path;
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
        image.value = downloadURL;
        Fluttertoast.showToast(msg: 'Foto produk berhasil di unggah');
      });

    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto produk gagal di unggah');
    }
  }

  editProduct()async{
    try{
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.EditProduct(
          name: edtName.text,
          description: edtDescription.text,
          image: image.value,
          price: int.parse(edtPrice.text),
          status: status.value,
          token: token!
      );
      if(r["message"] == "OK"){
        Fluttertoast.showToast(msg: "Edit produk berhasil");
      }else{
        Fluttertoast.showToast(msg: "Edit produk gagal");
      }
    }catch(e, stackTrace){
      Fluttertoast.showToast(msg: "ada yang salah");
      log('$e');
      log('$stackTrace');
    }
  }

  @override
  void onInit() {
    edtName.text = Get.arguments["name"];
    edtDescription.text = Get.arguments["description"];
    image.value = Get.arguments["image"];
    edtPrice.text = Get.arguments["price"].toString();
    super.onInit();
  }
}