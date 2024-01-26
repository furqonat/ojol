import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lugo_marchant/page/accout_info/api_accountinfo.dart';
import 'package:lugo_marchant/page/profile/controller_profile.dart';
import 'package:rest_client/shared.dart' as rest;

enum Status { idle, loading, success, failed }

class ControllerAccountInfo extends GetxController {
  final ApiAccountInfo api;
  ControllerAccountInfo({required this.api});

  var loading = Status.idle.obs;

  var showPassword = false.obs;
  var showConfirmPassword = false.obs;

  Rx<Marker?> marker = Rx<Marker?>(null);
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);

  late GoogleMapController googleMapController;

  final fullName = TextEditingController();
  final address = TextEditingController();
  final shopName = TextEditingController();
  final shopImages = [].obs;
  final phone = TextEditingController();
  final email = TextEditingController();
  final avatar = "".obs;
  final _fbAuth = FirebaseAuth.instance;
  final _fbStorage = FirebaseStorage.instance;
  final accountCtrl = Get.find<ControllerProfile>();

  final picker = ImagePicker();

  Future<void> handlePickImageFromGallery() async {
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    _handleUploadImage(file);
  }

  _handleUploadImage(XFile? file) {
    if (file != null) {
      final ref = _fbStorage.ref().child("user/merchant/${file.name}");
      final currentFile = File(file.path);
      final UploadTask task = ref.putFile(currentFile);
      task.whenComplete(() async {
        avatar.value = await ref.getDownloadURL();
        Fluttertoast.showToast(msg: "success upload image");
      });
    }
  }

  handleGetUser() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    api.getUser(token: token!).then((value) {
      fullName.value = TextEditingValue(text: value.name ?? '');
      address.value = TextEditingValue(text: value.detail?.address ?? '');
      phone.value = TextEditingValue(text: value.phone ?? '');
      email.value = TextEditingValue(text: value.email ?? '');
      avatar.value = value.avatar ?? '';
      if (value.detail?.images != null) {
        shopImages(
          RxList<String>(
            value.detail!.images!.map((e) => e.link).toList(),
          ),
        );
      }
    });
  }

  Future<rest.Response> handleUpdateUser() async {
    final token = await _fbAuth.currentUser?.getIdToken();
    final body = {
      "name": fullName.value.text,
      "avatar": avatar.value,
      "details": {
        "update": {
          "address": address.value.text,
        },
      },
    };
    await accountCtrl.getUser();
    return await api.updateUser(token: token!, body: body);
  }

  @override
  void dispose() {
    super.dispose();
    fullName.dispose();
    address.dispose();
    phone.dispose();
    email.dispose();
    shopName.dispose();
  }

  onMapTap(LatLng tappedPoint) {
    final newMarker = Marker(
      markerId: MarkerId(tappedPoint.toString()),
      position: tappedPoint,
      infoWindow: const InfoWindow(title: 'Lokasi Toko'),
    );

    marker.value = newMarker;
    selectedLocation.value = tappedPoint;

    googleMapController.animateCamera(CameraUpdate.newLatLng(tappedPoint));
  }

  @override
  void onInit() async {
    super.onInit();
    await handleGetUser();
  }
}
