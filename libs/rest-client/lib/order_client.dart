library rest_client;

import 'package:dio/dio.dart' show Dio, RequestOptions, Options, ResponseType;
import 'package:retrofit/retrofit.dart';

part 'order_client.g.dart';

@RestApi(baseUrl: 'https://order.gentatechnology.com/')
abstract class OrderClient {
  factory OrderClient(Dio dio, {String baseUrl}) = _OrderClient;

  @POST("")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future createOrder({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });

  @GET("driver")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future driverGetAvaliableOrder({
    @Header("Authorization") required String bearerToken,
  });

  @PUT("driver/{orderId}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future orderFindDriver({
    @Header("Authorization") required String bearerToken,
    @Path("orderId") required String orderId,
  });

  @PUT("driver/sign/{orderId}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future driverSignOrder({
    @Header("Authorization") required String bearerToken,
    @Path("orderId") required String orderId,
  });

  @PUT("driver/reject/{orderId}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future driverRejectOrder({
    @Header("Authorization") required String bearerToken,
    @Path("orderId") required String orderId,
  });

  @PUT("driver/accept/{orderId}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future driverAcceptOrder({
    @Header("Authorization") required String bearerToken,
    @Path("orderId") required String orderId,
  });

  @PUT("driver/finish/{orderId}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future driverFinishOrder({
    @Header("Authorization") required String bearerToken,
    @Path("orderId") required String orderId,
  });

  @PUT("merchant/accept/{orderId}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future merchantAcceptOrder({
    @Header("Authorization") required String bearerToken,
    @Path("orderId") required String orderId,
  });

  @PUT("merchant/reject/{orderId}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future merchantRejectOrder({
    @Header("Authorization") required String bearerToken,
    @Path("orderId") required String orderId,
  });

  @GET("merchant")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future merchantGetOrders({
    @Header("Authorization") required String bearerToken,
  });

  @GET("merchant/sell")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future merchantGetSell({
    @Header("Authorization") required String bearerToken,
  });

  @PUT("{orderId}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future cancelOrder({
    @Header("Authorization") required String bearerToken,
    @Path("orderId") required String orderId,
  });

  @GET("{orderId}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future getOrder({
    @Header("Authorization") required String bearerToken,
    @Path("orderId") required String orderId,
  });
}
