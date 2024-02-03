import 'dart:async';
import 'dart:math';
import 'dart:developer' as test;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/spherical_utils.dart';
import 'package:location/location.dart';
import 'package:lugo_customer/api/local_service.dart';
import 'package:lugo_customer/page/location_picker/api_locationpicker.dart';
import 'package:lugo_customer/response/transaction.dart';
import 'package:lugo_customer/route/route_name.dart';

class ControllerLocationPicker extends GetxController {
  final ApiLocationPicker api;
  ControllerLocationPicker({required this.api});

  var transaction = Transactions().obs;

  final FirebaseAuth firebase = FirebaseAuth.instance;

  var edtPickUp = TextEditingController();
  var edtDropOff = TextEditingController();
  var edtPackage = TextEditingController();
  var edtWeight = TextEditingController();
  var edtDiscount = TextEditingController();

  var requestType = "".obs;

  var payTypeList = [
    "Pembayaran",
    "DANA",
    "CASH",
  ].obs;

  var payType = "Pembayaran".obs;

  var firstStep = true.obs;
  var secondStep = false.obs;
  var deliveryStep = false.obs;

  final Location location = Location();

  final Completer<GoogleMapController> mapController = Completer();

  final markers = <Marker>[].obs;

  final PolylinePoints polylinePoints = PolylinePoints();

  RxList<LatLng> rute = <LatLng>[].obs;

  var distance = 0.0.obs;

  var price = 0.obs;

  var priceLoading = false.obs;

  @override
  void onInit() {
    getLocation();

    requestType(Get.arguments["request_type"]);
    firstStep(true);
    secondStep(false);
    deliveryStep(false);
    super.onInit();
  }

  argumentChecker() => Get.arguments['request_type'];

  Rx<LocationData> myLocation = LocationData.fromMap(
    {
      "latitude": -6.340760195639559,
      "longitude": 106.47253623803584,
    },
  ).obs;

  Rx<LocationData> destinationLocation =
      LocationData.fromMap({"latitude": 0.0, "longitude": 0.0}).obs;

  initialLocation() async {
    GoogleMapController googleMapController = await mapController.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 17,
          target: LatLng(
            myLocation.value.latitude!,
            myLocation.value.longitude!,
          ),
        ),
      ),
    );
  }

  getLocation() async {
    GoogleMapController googleMapController = await mapController.future;

    await location.getLocation().then((location) {
      myLocation.value = LocationData.fromMap({
        "latitude": location.latitude,
        "longitude": location.longitude,
      });

      geo
          .placemarkFromCoordinates(location.latitude!, location.longitude!)
          .then(
            (value) => edtPickUp.text =
                "${value.first.street}, ${value.first.subLocality}, ${value.first.locality}, ${value.first.administrativeArea}, ${value.first.country}, ${value.first.postalCode}",
          );

      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 17,
              target: LatLng(location.latitude!, location.longitude!))));

      markers.value = [
        Marker(
            markerId: const MarkerId('Lokasi saya'),
            position: LatLng(location.latitude!, location.longitude!))
      ];
    });

    location.onLocationChanged.listen((it) async {
      myLocation.value = it;

      geo.placemarkFromCoordinates(it.latitude!, it.longitude!).then((value) =>
          edtPickUp.text =
              "${value.first.street}, ${value.first.subLocality}, ${value.first.locality}, ${value.first.administrativeArea}, ${value.first.country}, ${value.first.postalCode}");

      markers.first = Marker(
          markerId: const MarkerId('Lokasi saya'),
          position: LatLng(it.latitude!, it.longitude!));
    });
  }

  setDestination(LatLng point) {
    final destination = Marker(
      markerId: const MarkerId("Tujuan"),
      position: point,
    );

    if (markers.length == 1) {
      markers.add(destination);

      destinationLocation.value = LocationData.fromMap({
        "latitude": point.latitude,
        "longitude": point.longitude,
      });

      geo.placemarkFromCoordinates(point.latitude, point.longitude).then(
          (value) => edtDropOff.text =
              "${value.first.street}, ${value.first.subLocality}, ${value.first.locality}, ${value.first.administrativeArea}, ${value.first.country}, ${value.first.postalCode}");
    } else if (markers.length == 2) {
      markers[1] = destination;

      destinationLocation.value = LocationData.fromMap({
        "latitude": point.latitude,
        "longitude": point.longitude,
      });

      geo.placemarkFromCoordinates(point.latitude, point.longitude).then(
          (value) => edtDropOff.text =
              "${value.first.street}, ${value.first.subLocality}, ${value.first.locality}, ${value.first.administrativeArea}, ${value.first.country}, ${value.first.postalCode}");
    } else {
      Fluttertoast.showToast(
          msg: "Kami tidak dapat menemukan anda atau titik jemput");
    }
  }

  setRoutes() async {
    priceLoading(true);
    rute.clear();

    var route = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyD2iESGIyoYaZVPffaXa42wmVp2NxKACcM',
        PointLatLng(myLocation.value.latitude!, myLocation.value.longitude!),
        PointLatLng(destinationLocation.value.latitude!,
            destinationLocation.value.longitude!));

    if (route.points.isNotEmpty) {
      for (var i in route.points) {
        rute.add(LatLng(i.latitude, i.longitude));
      }
    }

    double originalNumber = SphericalUtils.computeDistanceBetween(
            Point(myLocation.value.latitude!, myLocation.value.longitude!),
            Point(destinationLocation.value.latitude!,
                destinationLocation.value.longitude!))
        .toDouble();

    var proccess = originalNumber / 1000;

    int decimalPlaces = 2;

    double roundedNumber =
        double.parse(proccess.toStringAsFixed(decimalPlaces));

    distance(roundedNumber);

    setFee();
    priceLoading(false);
  }

  setFee() async {
    try {
      var token = await firebase.currentUser?.getIdToken();

      var r = await api.setFee(
          distance: distance.value,
          serviceType: requestType.value,
          token: token!);
      test.log("return => $r");
      if (r["message"] == "OK") {
        var value = r["price"];
        price.value = value;
      }
    } catch (e, stackTrace) {
      test.log("$e");
      test.log("$stackTrace");
    }
  }

  //untuk bike dan car shipping cost sama dengan gross amount
  createBikeCarOrder() async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.orderBikeCar(
          orderType: requestType.value,
          paymentType: payType.value,
          grossAmount: price.value, //harga awal
          netAmount: price.value, //harga di potong diskon
          totalAmount: price.value, //shipping cost + net amount
          shippingCost: price.value, //harga awal
          pickUpLatitude: myLocation.value.latitude!,
          pickUpLongitude: myLocation.value.longitude!,
          pickUpAddress: edtPickUp.text,
          dropLatitude: destinationLocation.value.latitude!,
          dropLongitude: destinationLocation.value.longitude!,
          dropAddress: edtDropOff.text,
          discountId: edtDiscount.text,
          token: token!);

      if (r["message"] == "Successfully create order") {
        var keeper = r;
        transaction.value = Transactions.fromJson(keeper);

        await LocalService()
            .setTransactionId(transaction: transaction.value.res);
        await LocalService().setRequestType(type: requestType.value);
        await LocalService().setPrice(prices: price.value);

        secondStep(false);
        firstStep(true);

        if (payType.value == 'DANA') {
          Get.offNamed(Routes.digitalPay, arguments: {
            'checkout_url': transaction.value.detail?.checkoutUrl,
            'request_type': requestType.value,
            'latitude': myLocation.value.latitude,
            'longitude': myLocation.value.longitude,
            'dstLatitude': destinationLocation.value.latitude,
            'dstLongitude': destinationLocation.value.longitude,
            'order_id': transaction.value.res,
            'price': price.value,
          });
        } else {
          Get.offNamed(Routes.checkOrder, arguments: {
            'request_type': requestType.value,
            'latitude': myLocation.value.latitude,
            'longitude': myLocation.value.longitude,
            'dstLatitude': destinationLocation.value.latitude,
            'dstLongitude': destinationLocation.value.longitude,
            'order_id': transaction.value.res,
            'price': price.value,
          });
        }
      }
    } catch (e, stackTrace) {
      test.log("$e");
      test.log("$stackTrace");
    }
  }

  //untuk delivery
  createDeliveryOrder() async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      var r = await api.orderDelivery(
          orderType: requestType.value,
          paymentType: payType.value,
          grossAmount: price.value,
          netAmount: price.value,
          totalAmount: price.value,
          shippingCost: price.value,
          weight: int.parse(edtWeight.text),
          pickUpLatitude: myLocation.value.latitude!,
          pickUpLongitude: myLocation.value.longitude!,
          pickUpAddress: edtPickUp.text,
          dropLatitude: destinationLocation.value.latitude!,
          dropLongitude: destinationLocation.value.longitude!,
          dropAddress: edtDropOff.text,
          discountId: edtDiscount.text,
          token: token!);

      if (r["message"] == "Successfully create order") {
        var keeper = r;
        transaction.value = Transactions.fromJson(keeper);

        await LocalService()
            .setTransactionId(transaction: transaction.value.res);
        await LocalService().setRequestType(type: requestType.value);
        await LocalService().setPrice(prices: price.value);

        deliveryStep(false);
        firstStep(true);

        if (payType.value == 'DANA') {
          Get.offNamed(Routes.digitalPay, arguments: {
            'checkout_url': transaction.value.detail?.checkoutUrl,
            'request_type': requestType.value,
            'latitude': myLocation.value.latitude,
            'longitude': myLocation.value.longitude,
            'dstLatitude': destinationLocation.value.latitude,
            'dstLongitude': destinationLocation.value.longitude,
            'order_id': transaction.value.res,
            'price': price.value,
          });
        } else {
          Get.offNamed(Routes.checkOrder, arguments: {
            'request_type': requestType.value,
            'latitude': myLocation.value.latitude,
            'longitude': myLocation.value.longitude,
            'dstLatitude': destinationLocation.value.latitude,
            'dstLongitude': destinationLocation.value.longitude,
            'order_id': transaction.value.res,
            'price': price.value,
          });
        }
      }
    } catch (e, stackTrace) {
      test.log("$e");
      test.log("$stackTrace");
    }
  }

  @override
  void dispose() {
    edtPickUp.dispose();
    edtDropOff.dispose();
    edtPackage.dispose();
    edtDiscount.dispose();
    super.dispose();
  }
}
