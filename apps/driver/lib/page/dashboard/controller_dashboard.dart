import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lugo_driver/api/local_serivce.dart';
import 'package:lugo_driver/response/driver.dart';
import 'package:lugo_driver/response/order.dart' as od;
import 'package:lugo_driver/response/rider.dart';
import 'package:lugo_driver/shared/controller/controller_user.dart';
import 'package:lugo_driver/shared/preferences.dart';
import 'package:lugo_driver/shared/query_builder.dart';
import 'package:lugo_driver/shared/utils.dart';
import 'package:rest_client/account_client.dart';
import 'package:rest_client/order_client.dart';

import '../../route/route_name.dart';
import 'api_dashboard.dart';

class OrderFirestore {
  final String? driverId;
  final String? orderId;

  OrderFirestore({
    this.driverId,
    this.orderId,
  });

  factory OrderFirestore.fromJson(Map<String, dynamic> json) {
    return OrderFirestore(
      driverId: json['driverId'],
      orderId: json['orderId'],
    );
  }
}

class ControllerDashboard extends GetxController {
  final ApiDashboard api;
  final OrderClient orderClient;
  final AccountClient accountClient;
  final LocalService localService;

  ControllerDashboard({
    required this.api,
    required this.orderClient,
    required this.accountClient,
    required this.localService,
  });

  final autoBid = true.obs;
  final driver = Driver().obs;
  var locationReady = false.obs;

  var showBottomSheet = false.obs;
  var showPickUpLocation = true.obs;
  var showDropDownLocation = false.obs;

  final firebase = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  final Location location = Location();

  final order = od.Order().obs;
  final orderFrs = OrderFirestore().obs;

  final locationData = LocationData.fromMap({"latitude": 0.0, "longitude": 0.0}).obs;

  final Completer<GoogleMapController> mapController = Completer();

  PolylinePoints polylinePoints = PolylinePoints();

  final rute = <LatLng>[].obs;
  RxSet<Marker> markers = RxSet<Marker>();

  final address = ''.obs;

  RxList<Riders> riders = <Riders>[].obs;

  userHelp(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: Get.width,
          height: Get.height * 0.35,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Text(
                    textAlign: TextAlign.center,
                    'Kontak & Informasi\nBantuan',
                    style: GoogleFonts.readexPro(
                      fontSize: 24,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          style: GoogleFonts.readexPro(
                              fontSize: 14, color: Colors.black87),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Whatsapp ',
                            ),
                            TextSpan(
                                text: '081234567899',
                                style: GoogleFonts.readexPro(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                )),
                          ]),
                    ),
                    const Spacer(),
                    const Icon(Icons.phone_rounded, color: Colors.green)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          style: GoogleFonts.readexPro(
                              fontSize: 14, color: Colors.black87),
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Email ',
                            ),
                            TextSpan(
                                text: 'admin@email.com',
                                style: GoogleFonts.readexPro(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                )),
                          ]),
                    ),
                    const Spacer(),
                    const Icon(Icons.email_rounded, color: Colors.red)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 1. initial setting
  handleSetAutoBid() async {
    final token = await firebase.currentUser?.getIdToken();
    final resp = await accountClient.updateDriverOrderSetting(
      bearerToken: "Bearer $token",
      body: {
        "autoBid": autoBid.value,
      },
    );
    if (resp.message == 'OK') {
      log("OK setAutoBid");
    }
  }

  handleGetAutoBid() async {
    final token = await firebase.currentUser?.getIdToken();
    final queries = QueryBuilder()
      ..addQuery("id", "true")
      ..addQuery("driver_settings", "true");
    final resp = await accountClient.getDriver(
      bearerToken: "Bearer $token",
      queries: queries.toMap(),
    );
    driver.value = Driver.fromJson(resp);
    autoBid.value = driver.value.setting?.autoBid ?? true;
    Preferences(LocalStorage.instance).setOrderStatus(driver.value.setting?.autoBid ?? true);
  }

  initialSetting() async {
    if (autoBid.value == false) {
      var step = Preferences(LocalStorage.instance).getOrderStep();
      var keeper = Preferences(LocalStorage.instance).getOrder();
      var decode = jsonDecode(keeper);
      order.value = od.Order.fromJson(decode);
      if (step == 'STEP_1') {
        showBottomSheet(true);
        markers.add(Marker(
            markerId: const MarkerId('Lokasi Tujuan'),
            position: LatLng(order.value.orderDetail!.latitude!,
                order.value.orderDetail!.longitude!)));
        setRoutes(order.value.orderDetail!.latitude, order.value.orderDetail!.longitude);
      } else if (step == 'STEP_2') {
        showBottomSheet(true);
        markers.add(Marker(
            markerId: const MarkerId('Lokasi Tujuan'),
            position: LatLng(order.value.orderDetail!.dstLatitude!, order.value.orderDetail!.dstLongitude!)));
        setRoutes(order.value.orderDetail!.dstLatitude, order.value.orderDetail!.dstLongitude);
      } else {
        log("tidak pesanan yang sedang berjalan");
      }
    }
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
                    value: autoBid.value,
                    onChanged: (value) async {
                      autoBid(value);
                      Preferences(LocalStorage.instance).setOrderStatus(value);
                      handleSetAutoBid();
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

    BitmapDescriptor iconMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/driver-marker.png",
    );

    await location.getLocation().then((location) {
      locationData.value = LocationData.fromMap({
        "latitude": location.latitude,
        "longitude": location.longitude,
        "isMock": 0,
      });

      geocoding.placemarkFromCoordinates(location.latitude!, location.longitude!).then(
              (value) => address(
              "${value.first.street}, ${value.first.subLocality}, ${value.first.locality}, ${value.first.administrativeArea}, ${value.first.country}, ${value.first.postalCode}"));

      markers.add(Marker(
          icon: iconMarker,
          markerId: const MarkerId('Lokasi saya'),
          position: LatLng(location.latitude!, location.longitude!)));

      updateLocation(location.latitude!, location.longitude!);
    });

    GoogleMapController googleMapController = await mapController.future;

    location.onLocationChanged.listen((it) async {
      locationData.value = it;

      googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(zoom: 17, target: LatLng(it.latitude!, it.longitude!))));

      geocoding.placemarkFromCoordinates(it.latitude!, it.longitude!).then((value) => address(
          "${value.first.street}, ${value.first.subLocality}, ${value.first.locality}, ${value.first.administrativeArea}, ${value.first.country}, ${value.first.postalCode}"),);

      markers.removeWhere((element) {
        if (element.markerId.value == const MarkerId('Lokasi saya').value) {
          return true;
        }
        return false;
      });

      markers.add(
        Marker(
          icon: iconMarker,
          markerId: const MarkerId('Lokasi saya'),
          position: LatLng(it.latitude!, it.longitude!),
        ),
      );

      updateLocation(it.latitude!, it.longitude!);
    });
  }

  updateLocation(double latitude, double longitude)async{
    try{
      var token = await firebase.currentUser?.getIdToken(true);
      await accountClient.updateDriverCoordinate(
          bearerToken: 'Bearer $token',
          body: {
            'latitude': latitude,
            'longitude': longitude
          });
    }catch(e, stackTrace){
      log('$e');
      log('$stackTrace');
    }
  }

  // 3. get order berdasarkan status order setting dan tampilin order dialog kalau sesuai
  Stream<List<OrderFirestore>> getOrder() => _db
      .collection('order')
      .where('driverId', isEqualTo: controllerUser.user.value.id)
      .orderBy('created_at', descending: true)
      .snapshots()
      .map((event) {
    return event.docs
        .map((e) => OrderFirestore.fromJson(e.data()))
        .toList();
  });

  getDetailOrder(String orderId) async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      var resp = await orderClient.getOrder(bearerToken: 'Bearer $token', orderId: orderId);
      if (resp != null) {
        order.value = od.Order.fromJson(resp);
        orderDialog(Get.context!);
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
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
                          customEmptyIcon: Icons.star_rounded,
                        )
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
              onPressed: () {
                acceptOrder();
                Get.back();
              },
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

  // 4. accept order
  acceptOrder({String? idOrder}) async {
    try {
      final token = await firebase.currentUser?.getIdToken();
      final resp = await orderClient.driverAcceptOrder(
        bearerToken: "Bearer $token",
        orderId: order.value.id ?? idOrder!,
      );
      if (resp["message"] == 'OK') {
        showBottomSheet(true);
        initiateChat();
        autoBid(false);
        Preferences(LocalStorage.instance).setOrderStatus(false);
        Preferences(LocalStorage.instance).setOrder(order.value);
        Preferences(LocalStorage.instance).setOrderStep('STEP_1');
        markers.add(Marker(
            markerId: const MarkerId('Lokasi Tujuan'),
            position: LatLng(order.value.orderDetail!.latitude!,
                order.value.orderDetail!.longitude!)));
        setRoutes(order.value.orderDetail!.latitude, order.value.orderDetail!.longitude);
        Get.back();
      } else {
        Fluttertoast.showToast(msg: "Ada yang salah");
      }
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

  initiateChat() async {
    try {
      var r = await api.makeRoomChat(
          id: order.value.id!,
          customer_id: order.value.customerId!,
          merchant_id: "",
          driver_id: controllerUser.user.value.id ?? 'user_id',
          dateTime: DateTime.now(),
          status: true);
      debugPrint(r);
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
  }

  // 5. driver otw
  driverOtw() async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      var r =
      await api.orderOtw(token: "Bearer $token", order_id: order.value.id!);
      if (r["message"] == "OK") {
        markers.removeWhere((element) {
          if (element.markerId.value == const MarkerId('Lokasi Tujuan').value) {
            return true;
          }
          return false;
        });
        markers.add(Marker(
            markerId: const MarkerId('Lokasi Tujuan'),
            position: LatLng(order.value.orderDetail!.dstLatitude!,
                order.value.orderDetail!.dstLongitude!)));
        setRoutes(order.value.orderDetail!.dstLatitude,
            order.value.orderDetail!.dstLongitude);
        Preferences(LocalStorage.instance).setOrderStep('STEP_2');
        showPickUpLocation(false);
        showDropDownLocation(true);
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
  }

  // 6. reject order
  rejectOrder() async {
    try {
      final token = await firebase.currentUser?.getIdToken();
      final resp = await orderClient.driverRejectOrder(
        bearerToken: "Bearer $token",
        orderId: order.value.id!,
      );
      if (resp["message"] == 'OK') {
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

  // 7. finish order
  finishOrder() async {
    try {
      var token = await firebase.currentUser?.getIdToken();
      var r = await orderClient.driverFinishOrder(bearerToken: 'Bearer $token', orderId: order.value.id!);
      if (r["message"] == 'OK') {
        Get.toNamed(Routes.orderFinish);
      }
    } catch (e, stackTrace) {
      log('$e');
      log('$stackTrace');
    }
  }

  @override
  void onInit() async {
    getLocation();
    initialSetting();
    handleGetAutoBid();
    super.onInit();
  }

  @override
  void onReady() {
    getOrder().listen((event) {
      for(var i in event){
        var checker = i.driverId == firebase.currentUser?.uid;
        if (checker == true){
          getDetailOrder(i.orderId ?? '');
        }
      }
    });
    super.onReady();
  }

  ControllerUser controllerUser = Get.find<ControllerUser>();
}
