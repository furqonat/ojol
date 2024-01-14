library rest_client;

import 'package:dio/dio.dart' show Dio, RequestOptions, Options, ResponseType;
import 'package:rest_client/shared.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_client.g.dart';

class Cart {
  final List<Map<String, dynamic>> data;
  final int total;

  Cart({required this.data, required this.total});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      data: (json['data'] as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)
          .toList(),
      total: json['total'],
    );
  }
}

@RestApi(baseUrl: "https://cart.gentatechnology.com/")
abstract class CartClient {
  factory CartClient(Dio dio, {String baseUrl}) = _CartClient;

  @GET("cart")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Cart> customerSignIn(
    @Header("Authorization") String token,
    @Queries() Map<String, dynamic> queries,
  );

  @POST("cart")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> addProductToCart(
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> queries,
  );

  @PUT("cart")
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<Response> updateProductFromCart(
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> queries,
  );
}
