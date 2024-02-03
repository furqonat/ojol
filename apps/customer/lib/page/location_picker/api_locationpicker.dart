import 'package:get/utils.dart';
import 'package:lugo_customer/api/api_service.dart';

class ApiLocationPicker {
  Future<dynamic> orderBikeCar({
    required String orderType,
    required String paymentType,
    required int grossAmount,
    required int netAmount,
    required int totalAmount,
    required int shippingCost,
    required double pickUpLatitude,
    required double pickUpLongitude,
    required String pickUpAddress,
    required double dropLatitude,
    required double dropLongitude,
    required String dropAddress,
    required String discountId,
    required String token,
  }) async {
    dynamic r;

    final discountBody = {
      "order_type": orderType,
      "payment_type": paymentType,
      "gross_amount": grossAmount,
      "net_amount": netAmount,
      "total_amount": totalAmount,
      "shipping_cost": shippingCost,
      "location": {
        "latitude": pickUpLatitude,
        "longitude": pickUpLongitude,
        "address": pickUpAddress,
      },
      "destination": {
        "latitude": dropLatitude,
        "longitude": dropLongitude,
        "address": dropAddress,
      },
      "discount_id": discountId
    };

    final body = {
      "order_type": orderType,
      "payment_type": paymentType,
      "gross_amount": grossAmount,
      "net_amount": netAmount,
      "total_amount": totalAmount,
      "shipping_cost": shippingCost,
      "location": {
        "latitude": pickUpLatitude,
        "longitude": pickUpLongitude,
        "address": pickUpAddress,
      },
      "destination": {
        "latitude": dropLatitude,
        "longitude": dropLongitude,
        "address": dropAddress,
      },
    };

    if (discountId.isEmpty || discountId.isBlank!) {
      r = await ApiService()
          .apiJSONPostWithFirebaseToken('order', '', body, token);
    } else {
      r = await ApiService()
          .apiJSONPostWithFirebaseToken('order', '', discountBody, token);
    }

    return r;
  }

  Future<dynamic> orderDelivery({
    required String orderType,
    required String paymentType,
    required int grossAmount,
    required int netAmount,
    required int totalAmount,
    required int shippingCost,
    required int weight,
    required double pickUpLatitude,
    required double pickUpLongitude,
    required String pickUpAddress,
    required double dropLatitude,
    required double dropLongitude,
    required String dropAddress,
    required String discountId,
    required String token,
  }) async {
    dynamic r;

    final discountBody = {
      "order_type": orderType,
      "payment_type": paymentType,
      "gross_amount": grossAmount,
      "net_amount": netAmount,
      "total_amount": totalAmount,
      "shipping_cost": shippingCost,
      "weight": weight,
      "location": {
        "latitude": pickUpLatitude,
        "longitude": pickUpLongitude,
        "address": pickUpAddress,
      },
      "destination": {
        "latitude": dropLatitude,
        "longitude": dropLongitude,
        "address": dropAddress,
      },
      "discount_id": discountId
    };

    final body = {
      "order_type": orderType,
      "payment_type": paymentType,
      "gross_amount": grossAmount,
      "net_amount": netAmount,
      "total_amount": totalAmount,
      "shipping_cost": shippingCost,
      "weight": weight,
      "location": {
        "latitude": pickUpLatitude,
        "longitude": pickUpLongitude,
        "address": pickUpAddress,
      },
      "destination": {
        "latitude": dropLatitude,
        "longitude": dropLongitude,
        "address": dropAddress,
      },
    };

    if (discountId.isEmpty || discountId.isBlank!) {
      r = await ApiService()
          .apiJSONPostWithFirebaseToken('order', '', body, token);
    } else {
      r = await ApiService()
          .apiJSONPostWithFirebaseToken('order', '', discountBody, token);
    }

    return r;
  }

  Future<dynamic> setFee(
      {required double distance,
      required String serviceType,
      required String token}) async {
    final body = {"distance": distance, "service_type": serviceType};

    var r = await ApiService()
        .apiJSONPostWithFirebaseToken('gate', 'lugo/fee/distance', body, token);
    return r;
  }
}
