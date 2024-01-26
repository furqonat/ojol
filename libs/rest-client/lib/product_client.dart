library rest_client;

import 'package:dio/dio.dart' show Dio, RequestOptions, ResponseType, Options;
import 'package:rest_client/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'product_client.g.dart';

@RestApi(baseUrl: 'https://product.gentatechnology.com/')
abstract class ProductClient {
  factory ProductClient(Dio dio, {String baseUrl}) = _ProductClient;

  @GET("")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<dynamic> getProducts({
    @Header("Authorization") required String bearerToken,
    @Queries() Map<String, dynamic>? queries,
  });

  @POST("")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> createProduct({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });

  @GET("merchants")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<dynamic> getMerchantProduct({
    @Header("Authorization") required String bearerToken,
    @Queries() Map<String, dynamic>? queries,
  });

  @GET("merchants/products")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<dynamic> getMerchantProducts({
    @Header("Authorization") required String bearerToken,
    @Queries() Map<String, dynamic>? queries,
  });

  @PUT("{id}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> updateProduct({
    @Header("Authorization") required String bearerToken,
    @Path("id") required String productId,
    @Body() required Map<String, dynamic> body,
  });

  @GET("{id}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<dynamic> getProduct({
    @Header("Authorization") required String bearerToken,
    @Path("id") required String productId,
    @Queries() Map<String, dynamic>? queries,
  });

  @GET("favorite/{id}")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> addOrDeleteProductFromFavorite({
    @Header("Authorization") required String bearerToken,
    @Path("id") required String productId,
  });

  @GET("category")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<dynamic> getProductCategories({
    @Header("Authorization") required String bearerToken,
    @Query("merchantId") String? merchantId,
    @Query("take") int? take = 20,
    @Query("skip") int? skip = 0,
  });

  @GET("merchant/category")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<dynamic> getMerchantProductCategories({
    @Header("Authorization") required String bearerToken,
    @Query("take") int? take = 20,
    @Query("skip") int? skip = 0,
  });

  @POST("category")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> createCategory({
    @Header("Authorization") required String bearerToken,
    @Body() required Map<String, dynamic> body,
  });
}
