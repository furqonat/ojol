library rest_client;

import 'package:dio/dio.dart' show Dio, RequestOptions, ResponseType, Options;
import 'package:retrofit/retrofit.dart';

part 'gate_client.g.dart';

@RestApi(baseUrl: 'https://gate.gentatechnology.com/')
abstract class GateClient {
  factory GateClient(Dio dio, {String baseUrl}) = _GateClient;

  @GET("oauth")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future customerGetSignInUrl({
    @Header("Authorization") required String bearerToken,
  });
  @GET("oauth/merchant")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future merchantGetSignInUrl({
    @Header("Authorization") required String bearerToken,
  });
  @GET("oauth/driver")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future driverGetSignInUrl({
    @Header("Authorization") required String bearerToken,
  });

  @GET("oauth/profile")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future customerGetDanaProfile({
    @Header("Authorization") required String bearerToken,
  });
  @GET("oauth/merchant/profile")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future merchantGetDanaProfile({
    @Header("Authorization") required String bearerToken,
  });
  @GET("oauth/driver/profile")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future driverGetDanaProfile({
    @Header("Authorization") required String bearerToken,
  });
}
