import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_marchant/page/category/api_category.dart';

class ControllerCategory extends GetxController with GetSingleTickerProviderStateMixin{
  final ApiCategory api;
  ControllerCategory ({required this.api});

  var categoryValue = "Kategori".obs;

  var categoryList= [
    "Kategori",
    "Makanan berat",
    "Makanan ringan",
    "Minuman",
  ].obs;

  late TabController tabController;

  final firebase = FirebaseAuth.instance;

  var edtName = TextEditingController();
  var edtPrice = TextEditingController();
  var edtQuantity = TextEditingController();
  var edtDescription = TextEditingController();
  var edtCategoryName = TextEditingController();
  var edtCategory = TextEditingController();

  var imgUrl = ''.obs;
  var img = ''.obs;
  XFile? file;

  final ImagePicker picker = ImagePicker();

  getFromCamera() async {
    final XFile? camImage = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      img.value = camImage.path;
      file = camImage;
      uploadImage();
    }
  }

  getFromFile() async {
    final XFile? fileImage =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      img.value = fileImage.path;
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
        imgUrl.value = downloadURL;
        Fluttertoast.showToast(msg: 'Foto profil berhasil di unggah');
      });

    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto profil gagal di unggah');
    }
  }

  uploadMenuNewCategory()async{
    try{
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.addProductWithNewCategory(
        name: edtName.text,
        description: edtDescription.text,
        image: imgUrl.value,
        price: int.parse(edtPrice.text),
        status: true,
        category_name: edtCategoryName.text,
        product_type: "FOOD",
        token: token!,
      );
      if (r["message"] == "OK"){
        Fluttertoast.showToast(msg: "Anda kini punya produk baru untuk di jual");
      }else{
        Fluttertoast.showToast(msg: "Anda tidak dapat menambahkan produk baru");
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
      Fluttertoast.showToast(msg: "Ada yang salah");
    }
  }

  uploadMenuCurrentCategory()async{
    try{
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.addProductWithCurrentCategory(
        name: edtName.text,
        description: edtDescription.text,
        image: imgUrl.value,
        price: int.parse(edtPrice.text),
        status: true,
        id: categoryValue.value,
        product_type: "FOOD",
        token: token!,
      );
      if (r["message"] == "OK"){
        Fluttertoast.showToast(msg: "Anda kini punya produk baru untuk di jual");
      }else{
        Fluttertoast.showToast(msg: "Anda tidak dapat menambahkan produk baru");
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
      Fluttertoast.showToast(msg: "Ada yang salah");
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    edtCategory.dispose();
    super.dispose();
  }
}