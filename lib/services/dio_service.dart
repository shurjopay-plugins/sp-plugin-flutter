import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shurjopay/utilities/global_objects.dart';

import '../utilities/functions.dart';

class SPDioService {
  Dio dio = Dio();
  late String env;

  Future<void> reset() async {
    BaseOptions options = BaseOptions(
      /*connectTimeout: 180000,
      receiveTimeout: 180000,*/
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio.options = options;
  }

  Future<void> update({
    required String baseURL,
    required String tokenType,
    required String token,
  }) async {
    BaseOptions options = BaseOptions(
      headers: {
        "Accept": "application/json",
        "Authorization": "$tokenType $token",
      },
      baseUrl: baseURL,
      /*connectTimeout: 180000,
      receiveTimeout: 180000,*/
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio.options = options;
  }

  Future<void> create({required String baseURL}) async {
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      /*connectTimeout: 180000,
      receiveTimeout: 180000,*/
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (showPrints) {
          printer("= = = Shurjopay Request = = =");
          printer(options.headers);
          printer(options.contentType);
          printer(options.extra);
          printer("${options.baseUrl}${options.path}");
          printer(options.data);
        }

        return handler.next(options);
      },
      onError: (DioError error, handler) async {
        if (showPrints) {
          printer("= = = Shurjopay Error Response = = =");
          printer('Error Response: ${error.response}');
          printer('Error Message: ${error.message}');
          printer('Error Type: ${error.type}');
        }

        return handler.next(error);
      },
      onResponse: (response, handler) {
        if (showPrints) {
          printer("= = = Shurjopay Success Response = = =");
          printer(response.headers);
          printer(
              response.requestOptions.baseUrl + response.requestOptions.path);
          printer(response.statusCode);
          printer(response.extra);
          printer(json.encode(response.data));
        }

        return handler.next(response);
      },
    ));
  }
}
