import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'api_service.dart';

class ApiServiceImpl implements ApiService {
  final Dio client;

  ApiServiceImpl(this.client) {
    client.httpClientAdapter = IOHttpClientAdapter()
      ..onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

    client.options
      ..baseUrl = 'https://www.googleapis.com/books/v1'
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) => status! < 500;
    // client.interceptors.add(sl<AppInterceptors>());
    // if (kDebugMode) client.interceptors.add(sl<LogInterceptor>());
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await client.get(
      path,
      queryParameters: queryParameters,
    );
    return _handleResponseAsJson(response);
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? body,
    bool formDataIsEnabled = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await client.post(
      path,
      queryParameters: queryParameters,
      data: formDataIsEnabled ? FormData.fromMap(body!) : body,
    );
    return _handleResponseAsJson(response);
  }

  @override
  Future put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response =
        await client.put(path, queryParameters: queryParameters, data: body);
    return _handleResponseAsJson(response);
  }

  @override
  Future delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await client.delete(
      path,
      queryParameters: queryParameters,
      data: body,
    );
    return _handleResponseAsJson(response);
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) => jsonDecode(
        response.data.toString(),
      );
}
