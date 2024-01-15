library rest_client;

import 'package:dio/dio.dart' show Dio, RequestOptions, ResponseType, Options;
import 'package:retrofit/retrofit.dart';

part 'transaction_client.g.dart';

@RestApi(baseUrl: 'https://api.gentatechnology.com/')
abstract class TransactionClient {
  factory TransactionClient(Dio dio, {String baseUrl}) = _TransactionClient;

  @GET("trx/merchant")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future getMerchantTransactions({
    @Header("Authorization") required String bearerToken,
  });

  @GET("trx/driver")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future getDriverTransactions({
    @Header("Authorization") required String bearerToken,
  });
}
