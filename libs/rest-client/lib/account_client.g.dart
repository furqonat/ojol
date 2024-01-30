// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AccountClient implements AccountClient {
  _AccountClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://account.gentatechnology.com/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<dynamic> getCustomer({
    required String bearerToken,
    Map<String, dynamic>? queries,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
        .compose(
          _dio.options,
          'customer',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = _result.data;
    return value;
  }

  @override
  Future<Response> customerAssignDeviceToken({
    required String bearerToken,
    required DeviceToken body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'customer/token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> basicUpdateCustomer({
    required String bearerToken,
    required Map<String, dynamic> body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'customer',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> customerVerifyPhoneNumber({
    required String bearerToken,
    required Verification body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'customer/phone/verification',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> customerFinishVerifyPhoneNumber({
    required String bearerToken,
    required String id,
    required VerifyPhoneNumber body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'customer/phone/verification/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> getDriver({
    required String bearerToken,
    Map<String, dynamic>? queries,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
        .compose(
          _dio.options,
          'driver',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = _result.data;
    return value;
  }

  @override
  Future<Response> applyToBeDriver({
    required String bearerToken,
    required Map<String, dynamic> body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'driver',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> updateApplyToBeDriver({
    required String bearerToken,
    required Map<String, dynamic> body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'driver',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> driverAssignDeviceToken({
    required String bearerToken,
    required DeviceToken body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'driver/token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> updateDriverSetting({
    required String bearerToken,
    required Map<String, dynamic> body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'driver/setting',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> updateDriverOrderSetting({
    required String bearerToken,
    required Map<String, dynamic> body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'driver/setting/order',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> updateDriverCoordinate({
    required String bearerToken,
    required Map<String, dynamic> body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'driver/setting/coordinate',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> driverVerifyPhoneNumber({
    required String bearerToken,
    required Verification body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'driver/phone/verification',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> driverFinishVerifyPhoneNumber({
    required String bearerToken,
    required String id,
    required VerifyPhoneNumber body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'driver/phone/verification/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<dynamic> getMerchant({
    required String bearerToken,
    Map<String, dynamic>? queries,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch(_setStreamType<dynamic>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
        .compose(
          _dio.options,
          'merchant',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = _result.data;
    return value;
  }

  @override
  Future<Response> applyToBeMerchant({
    required String bearerToken,
    required Map<String, dynamic> body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'merchant',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> updateMerchant({
    required String bearerToken,
    required Map<String, dynamic> body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'merchant/{id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> createOperationTime({
    required String bearerToken,
    required Map<String, dynamic> body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'merchant/operation',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> updateOperationTime({
    required String bearerToken,
    required String operationTimeId,
    required Map<String, dynamic> body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'PUT',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'merchant/operation/${operationTimeId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> merchantAssignDeviceToken({
    required String bearerToken,
    required DeviceToken body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'merchant/token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> merchantVerifyPhoneNumber({
    required String bearerToken,
    required Verification body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'merchant/phone/verification',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Response> merchantFinishVerifyPhoneNumber({
    required String bearerToken,
    required String id,
    required VerifyPhoneNumber body,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<Response>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              'merchant/phone/verification/${id}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = Response.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
