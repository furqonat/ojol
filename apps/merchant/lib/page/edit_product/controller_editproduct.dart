import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_marchant/page/edit_product/api_editproduct.dart';

class ControllerEditProduct extends GetxController {
  ControllerEditProduct({required this.api});
  final ApiEditProduct api;

  final productId = Get.arguments['id'];
  final name = TextEditingController();
  final description = TextEditingController();
  final image = ''.obs;

  final price = TextEditingController();
  final status = false.obs;

  final ImagePicker picker = ImagePicker();

  final firebase = FirebaseAuth.instance;

  getFromCamera() async {
    final XFile? camImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (camImage != null) {
      uploadImage(camImage);
    }
  }

  getFromFile() async {
    final XFile? fileImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (fileImage != null) {
      uploadImage(fileImage);
    }
  }

  uploadImage(XFile? file) async {
    if (file == null) {
      log('Error: File is null.');
      return;
    }

    String fileName = file.name;
    final path = 'product/images/$fileName';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      File fileToUpload = File(file.path);

      UploadTask uploadTask = ref.putFile(fileToUpload);

      uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        image.value = downloadURL;
        await handleSaveEditProduct();
        Fluttertoast.showToast(msg: 'Foto produk berhasil di unggah');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Foto produk gagal di unggah');
    }
  }

  handleSaveEditProduct() async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      final resp = await api.editProduct(
        name: name.text,
        description: description.text,
        image: image.value,
        price: int.parse(price.text),
        status: status.value,
        productId: productId,
        token: token!,
      );
      if (resp.message == "OK") {
        Fluttertoast.showToast(msg: "Edit produk berhasil");
      } else {
        Fluttertoast.showToast(msg: "Edit produk gagal");
      }
    } catch (e, stackTrace) {
      Fluttertoast.showToast(msg: "ada yang salah");
      log('$e');
      log('$stackTrace');
    }
  }

  @override
  void onInit() async {
    final token = await firebase.currentUser?.getIdToken();
    api.getProduct(productId: productId, token: token!).then((value) {
      name.value = TextEditingValue(text: value['name'] ?? '');
      price.value = TextEditingValue(text: value['price'].toString());
      description.value = TextEditingValue(text: value['description'] ?? '');
      image.value = value['image'] ?? '';
      status.value = value['status'] ?? false;
    });
    super.onInit();
  }
}
