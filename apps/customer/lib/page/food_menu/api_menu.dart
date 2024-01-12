import 'package:lugo_customer/api/api_service.dart';

class ApiFoodMenu{

  Future<dynamic> getProducts ({required String token})async{
    var r = await ApiService().apiJSONGetWitFirebaseToken('product/?id=true&name=true&description=true&price=true&image=true&_count={select: {customer_product_review: true}}&favorites={select: {customer_id: true}}', token);
    return r;
  }

  Future<dynamic> postLikeProduct ({required String id_product, required String token}) async {
    var r = await ApiService().apiJSONGetWitFirebaseToken('product/product/favorite/$id_product', token);
    return r;
  }

  Future<dynamic> cart ({required String id_product, required int quantity, required String token})async{
    final body = {
      'productId' : id_product,
      'quantity' : quantity
    };
    
    var r = await ApiService().apiJSONPostWithFirebaseToken('cart', body, token);
    return r;
  }

  Future<dynamic> getCart ({required String token})async{
    var r = await ApiService().apiJSONGetWitFirebaseToken('cart', token);
    return r;
  }

}