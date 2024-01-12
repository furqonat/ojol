import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'api_form.dart';

enum Status { idle, loading, success, failed }

class ControllerForm extends GetxController{
  final ApiForm api;
  ControllerForm({required this.api});

  var loading = Status.idle.obs;

  var showPassword = false.obs;
  var showConfirmPassword = false.obs;

  Rx<Marker?> marker = Rx<Marker?>(null);
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);

  late GoogleMapController googleMapController;

  var edtFullName = TextEditingController();
  var edtCompleteAddress = TextEditingController();
  var edtPhone = TextEditingController();
  var edtEmail = TextEditingController();
  var edtTypeTransport = TextEditingController();
  var edtBrandTransport = TextEditingController();
  var edtYearTransport = TextEditingController();
  var edtPassword = TextEditingController();
  var edtConfirmPassword = TextEditingController();

  @override
  void dispose() {
    edtFullName.dispose();
    edtCompleteAddress.dispose();
    edtPhone.dispose();
    edtEmail.dispose();
    edtTypeTransport.dispose();
    edtBrandTransport.dispose();
    edtYearTransport.dispose();
    super.dispose();
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
}