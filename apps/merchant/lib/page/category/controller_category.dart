import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_marchant/page/category/api_category.dart';
import 'package:lugo_marchant/response/category.dart';

class ControllerCategory extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiCategory api;
  ControllerCategory({required this.api});

  var categoryValue = "Kategori".obs;
  final categodyId = "".obs;

  late TabController tabController;

  final firebase = FirebaseAuth.instance;

  var edtName = TextEditingController();
  var edtPrice = TextEditingController();
  var edtQuantity = TextEditingController();
  var edtDescription = TextEditingController();
  var edtCategoryName = TextEditingController();

  var categoryName = TextEditingController();
  var imgUrl = ''.obs;
  var img = ''.obs;
  XFile? file;

  final ImagePicker picker = ImagePicker();
  final category = <Category>[].obs;

  handleGetCategory() async {
    final token = await firebase.currentUser?.getIdToken();
    final resp = await api.getMerchantCategories(token: token!);
    resp.add(Category(id: "", name: "Kategori"));
    category(resp.map((e) => Category(id: e.id, name: e.name)).toList());
  }

  handleCreateCategory() async {
    final token = await firebase.currentUser?.getIdToken();
    final resp = await api.createCategory(
      token: token!,
      name: categoryName.text,
    );
    if (resp.message == 'OK') {
      Fluttertoast.showToast(msg: "success create category");
      handleGetCategory();
    } else {
      Fluttertoast.showToast(msg: "unable create category");
    }
  }

  getFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
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
    final path = 'merchant/products/$fileName';
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

  handleCreateProduct() async {
    if (categodyId.value != "") {
      await _handleCreateProductWithCurrentCategory();
      Get.back();
      return;
    }
    await _handleCreateProductWithNewCategory();
    Get.back();
    return;
  }

  _handleCreateProductWithNewCategory() async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.addProductWithNewCategory(
        name: edtName.text,
        description: edtDescription.text,
        image: imgUrl.value,
        price: int.parse(edtPrice.text),
        status: true,
        categoryName: edtCategoryName.text,
        productType: "FOOD",
        token: token!,
      );
      if (r.message == "OK") {
        Fluttertoast.showToast(
          msg: "Anda kini punya produk baru untuk di jual",
        );
      } else {
        Fluttertoast.showToast(msg: "Anda tidak dapat menambahkan produk baru");
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
      Fluttertoast.showToast(msg: "Ada yang salah");
    }
  }

  _handleCreateProductWithCurrentCategory() async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.addProductWithCurrentCategory(
        name: edtName.text,
        description: edtDescription.text,
        image: imgUrl.value,
        price: int.parse(edtPrice.text),
        status: true,
        categoryId: categodyId.value,
        productType: "FOOD",
        token: token!,
      );
      if (r.message == "OK") {
        Fluttertoast.showToast(
            msg: "Anda kini punya produk baru untuk di jual");
      } else {
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
    handleGetCategory();
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    categoryName.dispose();
    super.dispose();
  }
}
