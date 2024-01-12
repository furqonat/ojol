import 'package:lugo_marchant/api/api_service.dart';

class ApiEditProduct{
  Future<dynamic> EditProduct({
    required String name,
    required String description,
    required String image,
    required int price,
    required bool status,
    required String token,
  })async{

    final body = {
      "name" : name,
      "description" : description,
      "image" : image,
      "price" : price,
      "status" : status,
    };

    var r = await ApiService().apiJSONPutWithFirebaseToken('product/', body, token);
    return r;

  }
}