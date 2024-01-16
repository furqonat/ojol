import 'dart:async';
import 'dart:developer';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lugo_driver/api/local_serivce.dart';
import 'package:lugo_driver/response/order.dart';
import 'package:lugo_driver/response/rider.dart';
import 'package:lugo_driver/shared/controller/controller_user.dart';
import 'package:lugo_driver/shared/utils.dart';
import 'api_dashboard.dart';

class ControllerDashboard extends GetxController {
  final ApiDashboard api;
  ControllerDashboard({required this.api});

  var orderSetting = true.obs;
  var locationReady = false.obs;
  var docId = "".obs;
  var orderType = "".obs;

  var showBottomSheet = false.obs;
  var showPickUpLocation = true.obs;
  var showDropDownLocation = false.obs;

  final firebase = FirebaseAuth.instance;

  final Location location = Location();

  var order = Order().obs;

  Rx<LocationData> locationData =
      LocationData.fromMap({"latitude": 0.0, "longitude": 0.0}).obs;

  final Completer<GoogleMapController> mapController = Completer();

  PolylinePoints polylinePoints = PolylinePoints();

  RxList<LatLng> rute = <LatLng>[].obs;

  var address = ''.obs;

  late StreamSubscription<List<Order>> check;

  late StreamSubscription<List<Riders>> checkRider;

  RxList<Riders> riders = <Riders>[].obs;

  // 1. cek status nerima order dari penyimpanan lokal
  initialSetting() async {
    var statusOrder = await LocalService().getOrderStatus();
    if (statusOrder != null) {
      orderSetting.value = statusOrder;
    }
  }

  // 2. sekarang kita track lokasi
  getLocation() async {
    var permission = await location.hasPermission();
    var service = await location.serviceEnabled();
    if (permission != PermissionStatus.granted ||
        permission != PermissionStatus.grantedLimited) {
      await location.requestPermission();
    }
    if (!service) {
      await location.requestService();
    }

    await location.getLocation().then((location) {
      locationData.value = LocationData.fromMap(
          {"latitude": location.latitude, "longitude": location.longitude});

      geo
          .placemarkFromCoordinates(location.latitude!, location.longitude!)
          .then((value) => address(
              "${value.first.street}, ${value.first.subLocality}, ${value.first.locality}, ${value.first.administrativeArea}, ${value.first.country}, ${value.first.postalCode}"));
    });

    GoogleMapController googleMapController = await mapController.future;

    location.onLocationChanged.listen((it) async {
      locationData.value = it;

      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 17, target: LatLng(it.latitude!, it.longitude!))));

      geo.placemarkFromCoordinates(it.latitude!, it.longitude!).then((value) =>
          address(
              "${value.first.street}, ${value.first.subLocality}, ${value.first.locality}, ${value.first.administrativeArea}, ${value.first.country}, ${value.first.postalCode}"));

      await api.listenLocation(
          id: controllerUser.user.value.id ?? "user id",
          address: address.value,
          isOnline: orderSetting.value,
          latitude: num.parse(it.latitude.toString()),
          longitude: num.parse(it.longitude.toString()),
          name: controllerUser.user.value.name ?? "name",
          type: orderType.value,
          document: docId.value);
    });
  }

  // 3. get order berdasarkan status order setting dan tampilin order dialog kalau sesuai
  Stream<List<Order>> getOrder() {
    return api.getOrder(fromJson: (data) => Order.fromJson(data));
  }

  orderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Obx(() => Row(
              children: <Widget>[
                Text(
                  order.value.orderType ?? "Tipe Pesanan",
                  style: GoogleFonts.readexPro(
                      fontSize: 20,
                      color: const Color(0xFF3978EF),
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Icon(
                    order.value.orderType == "FOOD" ||
                            order.value.orderType == "DELIVERY"
                        ? Icons.directions_bike_rounded
                        : Icons.directions_car_rounded,
                    color: const Color(0xFF3978EF))
              ],
            )),
        content: SizedBox(
          width: Get.width,
          height: Get.height * 0.4,
          child: Obx(() => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: Get.width * 0.3,
                          child: Text(
                            order.value.customerId ?? "User ID",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.readexPro(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Spacer(),
                        AnimatedRatingStars(
                            starSize: 20,
                            onChanged: (p0) {},
                            customFilledIcon: Icons.star_rounded,
                            customHalfFilledIcon: Icons.star_rounded,
                            customEmptyIcon: Icons.star_rounded)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Order ID",
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "123xxxxx",
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Biaya",
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          convertToIdr(10000, 0),
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 5),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Text(
                  //         "Jarak",
                  //         style: GoogleFonts.readexPro(
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //       const Spacer(),
                  //       Text(
                  //         '1 KM',
                  //         style: GoogleFonts.readexPro(
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Pembayaran",
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          order.value.paymentType ?? "-",
                          style: GoogleFonts.readexPro(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: Get.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: const Color(0xFF3978EF),
                        )),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      order.value.orderDetail?.address ?? 'Titik jemput',
                      style: GoogleFonts.readexPro(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: Get.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: Colors.deepOrangeAccent,
                        )),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      order.value.orderDetail?.dstAddress ?? "Titik antar",
                      style: GoogleFonts.readexPro(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              )),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          OutlinedButton(
              onPressed: () => acceptOrder(),
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF3978EF), width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              child: Text(
                "Terima",
                style: GoogleFonts.readexPro(
                  fontSize: 12,
                  color: const Color(0xFF3978EF),
                ),
              )),
          OutlinedButton(
              onPressed: () => rejectOrder(),
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.deepOrange, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              child: Text(
                "Tolak",
                style: GoogleFonts.readexPro(
                  fontSize: 12,
                  color: Colors.deepOrange,
                ),
              )),
        ],
      ),
    );
  }

  // 4. kalau terima jalan method accept order, tunjukan bottom sheet, buat room chat dan pastikan order setting jadi false supaya nanti pas di jalan gk keganggu sama orderan lain
  acceptOrder() async {
    try {
      final token = await firebase.currentUser?.getIdToken();
      var r = await api.acceptOrder(order_id: order.value.id!, token: token!);
      if (r["message"] == 'OK') {
        showBottomSheet(true);
        initiateChat();
        orderSetting(false);
        Get.back();
      } else {
        Fluttertoast.showToast(msg: "Ada yang salah");
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
  }

  initiateChat() async {
    try {
      var r = await api.makeRoomChat(
          customer_name: order.value.customer!.name!,
          merchant_name: order.value.customer!.name!,
          driver_name: order.value.customer!.name!,
          customer_id: controllerUser.user.value.id!,
          merchant_id: controllerUser.user.value.id!,
          driver_id: controllerUser.user.value.id!,
          status: true);
      print(r);
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
  }

  setRoutes(var latitude, var longitude) async {
    rute.clear();

    var start = PointLatLng(
        locationData.value.latitude!, locationData.value.longitude!);

    var route = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyD2iESGIyoYaZVPffaXa42wmVp2NxKACcM',
        start,
        PointLatLng(latitude, longitude));

    if (route.points.isNotEmpty) {
      for (var i in route.points) {
        rute.add(LatLng(i.latitude, i.longitude));
      }
    }
  }

  // 5. kalau tolak jalankan method reject
  rejectOrder() async {
    try {
      final token = await firebase.currentUser?.getIdToken();
      var r = await api.rejectOrder(order_id: order.value.id!, token: token!);
      if (r["message"] == 'OK') {
        Fluttertoast.showToast(msg: "Anda telah membatalkan pesanan");
        Get.back();
      } else {
        Fluttertoast.showToast(msg: "Ada yang salah");
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
  }

  // 6. jangan lupa inisiasi lokasi jangan lupa
  Future<List<Riders>> checkLocation() {
    return api.getDriver(fromJson: (data) => Riders.fromJson(data));
  }

  initiateLocation() async {
    try {
      var r = await api.initialLocation(
          id: controllerUser.user.value.id ?? "user id",
          address: address.value,
          isOnline: orderSetting.value,
          latitude: locationData.value.latitude ?? 0,
          longitude: locationData.value.longitude ?? 0,
          name: controllerUser.user.value.name ?? "user name",
          type: orderType.value);
      docId(r);
      await LocalService().setDocument(doc: r);
    } catch (e, stackTrace) {
      log("$e");
      log("$stackTrace");
    }
  }

  @override
  void onInit() async {
    orderType.value = await LocalService().getOrderType() ?? "-";

    docId.value = await LocalService().getDocument() ?? "";

    initialSetting();
    getLocation();
    if (orderSetting.value == true) {
      check = getOrder().listen((event) {
        if (event.last.id == controllerUser.user.value.id) {
          orderDialog(Get.context!);
        }
      });
    }

    checkLocation().then((it) {
      locationReady.value = it.any((element) => element.id == "user id");

      if (!locationReady.value) {
        initiateLocation();
      } else {
        log("lokasi sudah terdaftar");
      }
    });

    super.onInit();
  }

  settingDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          'Pengaturan',
          style:
              GoogleFonts.readexPro(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: Get.width,
          height: Get.height * 0.08,
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        "Otomatis menerima pesanan",
                        style: GoogleFonts.readexPro(
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Switch.adaptive(
                        activeColor: const Color(0xFF3978EF),
                        value: orderSetting.value,
                        onChanged: (value) async {
                          orderSetting(value);
                          await LocalService()
                              .setOrderStatus(statusOrder: value);
                        },
                      )
                    ],
                  ),
                ],
              )),
        ),
        actionsAlignment: MainAxisAlignment.center,
      ),
    );
  }

  ControllerUser controllerUser = Get.find<ControllerUser>();
}
