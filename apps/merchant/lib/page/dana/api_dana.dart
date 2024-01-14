import 'package:lugo_marchant/response/dana.dart';
import 'package:rest_client/gate_client.dart';

class ApiDana {
  final GateClient gateClient;

  ApiDana({required this.gateClient});

  Future<List<DanaProfile>> getDanaProfile({required String token}) async {
    final resp = await gateClient.merchantGetDanaProfile(
      bearerToken: "Bearer $token",
    );
    return (resp as List).map((e) => DanaProfile.fromJson(e)).toList();
  }
}
