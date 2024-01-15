library rest_client;

import 'package:dio/dio.dart' show Dio, RequestOptions, ResponseType, Options;
import 'package:rest_client/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'transaction_client.g.dart';

@RestApi(baseUrl: 'https://api.gentatechnology.com/')
abstract class TransactionClient {
  factory TransactionClient(Dio dio, {String baseUrl}) = _TransactionClient;

  @GET("trx/merchant")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<Transaction>> getMerchantTransactions({
    @Header("Authorization") required String bearerToken,
    @Queries() Map<String, dynamic>? queries,
  });

  @GET("trx/driver")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<List<Transaction>> getDriverTransactions({
    @Header("Authorization") required String bearerToken,
    @Queries() Map<String, dynamic>? queries,
  });
}
