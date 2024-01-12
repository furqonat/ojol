library rest_client;

import 'package:dio/dio.dart' show Dio, RequestOptions, ResponseType, Options;
import 'package:retrofit/retrofit.dart';

import 'shared.dart';

part 'account_client.g.dart';

class DeviceToken {
  final String token;

  DeviceToken({
    required this.token,
  });

  factory DeviceToken.fromJson(Map<String, dynamic> json) => DeviceToken(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}

@RestApi(baseUrl: 'https://account.gentatechnology.com/')
abstract class AccountClient {
  factory AccountClient(Dio dio, {String baseUrl}) = _AccountClient;

  @GET('customer')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<dynamic> getCustomer({
    @Header("Authorization") required String bearerToken,
    @Queries() Map<String, dynamic>? queries,
  });

  @POST('customer/token')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> customerAssignDeviceToken({
    @Header("Authorization") required String bearerToken,
    @Body() required DeviceToken body,
  });

  @PUT('customer')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> basicUpdateCustomer({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });

  @GET('driver')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<dynamic> getDriver({
    @Header("Authorization") required String bearerToken,
    @Queries() Map<String, dynamic>? queries,
  });

  @POST('driver')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> applyToBeDriver({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });

  @PUT('driver')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> updateApplyToBeDriver({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });

  @POST('driver/token')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> driverAssignDeviceToken({
    @Header("Authorization") required String bearerToken,
    @Body() required DeviceToken body,
  });

  @PUT('driver/setting')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> updateDriverSetting({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });

  @PUT('driver/setting/order')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> updateDriverOrderSetting({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });

  @PUT('driver/setting/coordinate')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> updateDriverCoordinate({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });

  @GET('merchant')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<dynamic> getMerchant({
    @Header("Authorization") required String bearerToken,
    @Queries() Map<String, dynamic>? queries,
  });

  @POST('merchant')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> applyToBeMerchant({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });

  @PUT('merchant/{id}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> updateMerchant({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });

  @POST('merchant/operation')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> createOperationTime({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });

  @PUT('merchant/operation/{id}')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> updateOperationTime({
    @Header("Authorization") required String bearerToken,
    @Path("id") required String operationTimeId,
    @Body() required Map<String, dynamic> body,
  });

  @POST('merchant/token')
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> merchantAssignDeviceToken({
    @Header("Authorization") required String bearerToken,
    @Body() required DeviceToken body,
  });
}
