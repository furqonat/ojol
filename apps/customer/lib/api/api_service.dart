import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  String protocolCode = 'https://';
  String baseUrl = '.gentatechnology.com/';

  Future<dynamic> apiJSONGet(String url) async {
    dynamic data;
    try {
      Map<String, String> headers = {
        'content-Type': 'application/json',
      };
      log('headers = $headers');
      log('url = $baseUrl$url');

      http.Response r =
          await http.get(Uri.parse(baseUrl + url), headers: headers);
      log("status codenya ${r.statusCode}");
      log(r.body.toString());
      data = json.decode(r.body);
      // log(data.toString());
      // logApi(url: url, res: r, method: "GET");
    } on SocketException {
      data = "Tidak ada koneksi internet";
    } catch (e) {
      data = "terjadi kesalahan";
    }

    return data;
  }

  Future<dynamic> apiJSONPost(String url, Map<String, dynamic> params) async {
    dynamic data;

    try {
      Map<String, String> headers = {
        'content-Type': 'application/json',
      };
      log('headers = $headers');
      log('url = $baseUrl$url');

      var r = await http.post(Uri.parse(baseUrl + url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(params),
          encoding: Encoding.getByName("utf-8"));
      data = jsonDecode(r.body);
      log("status codenya ${r.statusCode}");
      // log(data.toString());
      // logApi(url: url, res: r, method: "POST", payload: params);
    } on SocketException {
      data = "Tidak ada koneksi internet";
    } catch (e) {
      data = "terjadi kesalahan";
    }

    return data;
  }

  Future<dynamic> apiJSONPut(String url, Map<String, dynamic> params) async {
    dynamic data;
    try {
      Map<String, String> headers = {
        'content-Type': 'application/json',
      };
      log('headers = $headers');
      log('url = $baseUrl$url');

      var r = await http.put(Uri.parse(baseUrl + url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(params),
          encoding: Encoding.getByName("utf-8"));
      data = jsonDecode(r.body);
      log("status codenya ${r.statusCode}");
      // log(data.toString());
      // logApi(url: url, res: r, method: "PUT", payload: params);
    } on SocketException {
      data = "Tidak ada koneksi internet";
    } catch (e) {
      data = "Terjadi Kesalahan";
    }

    return data;
  }

  Future<dynamic> apiJSONDelete(String url) async {
    dynamic data;
    try {
      Map<String, String> headers = {
        'content-Type': 'application/json',
      };
      log('headers = $headers');
      log('url = $baseUrl$url');

      var r = await http.delete(Uri.parse(baseUrl + url),
          headers: {"Content-Type": "application/json"});
      if (r.statusCode == 204) {
        data = {"success": true};
      } else {
        var error = jsonDecode(r.body);
        log("status codenya ${r.statusCode}, error: $error");
        throw Exception("Failed to delete data");
      }
    } on SocketException {
      data = "Tidak ada koneksi internet";
    } catch (e) {
      data = "Terjadi kesalahan";
    }

    return data;
  }

  Future<dynamic> apiJSONGetWitFirebaseToken(
      String midPoint, String endPoint, String token) async {
    dynamic data;
    try {
      Map<String, String> headers = {
        'content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      log('headers = $headers');
      log('url = $protocolCode$midPoint$baseUrl$endPoint');

      http.Response r = await http.get(
          Uri.parse(protocolCode + midPoint + baseUrl + endPoint),
          headers: headers);
      log("status codenya ${r.statusCode}");

      data = json.decode(r.body);
      // log('$data');
      // logApi(url: url, res: r, method: "GET");
    } on SocketException {
      data = "Tidak ada koneksi internet";
    } catch (e) {
      data = e;
    }

    return data;
  }

  Future<dynamic> apiJSONPostWithFirebaseToken(String midPoint, String endPoint,
      Map<String, dynamic> params, String token) async {
    dynamic data;
    try {
      Map<String, String> headers = {
        'content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      log('headers = $headers');
      log('url = $protocolCode$midPoint$baseUrl$endPoint');

      var r = await http.post(
          Uri.parse(protocolCode + midPoint + baseUrl + endPoint),
          headers: headers,
          body: jsonEncode(params),
          encoding: Encoding.getByName("utf-8"));
      data = jsonDecode(r.body);
      log("status codenya ${r.statusCode}");
      // log(data.toString());
      // logApi(url: url, res: r, method: "POST", payload: params);
    } on SocketException {
      data = "Tidak ada koneksi internet";
    } catch (e) {
      data = e;
    }

    return data;
  }

  Future<dynamic> apiJSONPutWithFirebaseToken(String midPoint, String endPoint,
      Map<String, dynamic> params, String token) async {
    dynamic data;
    try {
      Map<String, String> headers = {
        'content-Type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      log('headers = $headers');
      log('url = $protocolCode$midPoint$baseUrl$endPoint');

      var r = await http.put(
          Uri.parse(protocolCode + midPoint + baseUrl + endPoint),
          headers: headers,
          body: jsonEncode(params),
          encoding: Encoding.getByName("utf-8"));
      data = jsonDecode(r.body);
      log("status codenya ${r.statusCode}");
      log(data.toString());
      // logApi(url: url, res: r, method: "POST", payload: params);
    } on SocketException {
      data = "Tidak ada koneksi internet";
    } catch (e) {
      data = "Terjadi kesalahan";
    }

    return data;
  }
}
