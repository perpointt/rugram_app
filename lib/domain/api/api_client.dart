import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rugram/data/api/api_client.dart';
import 'package:rugram/domain/api/api_methods.dart';
import 'package:rugram/domain/models/app_exception.dart';

class ApiClientImpl implements ApiClient {
  ApiClientImpl([List<Interceptor> interceptors = const <Interceptor>[]]) {
    _install(interceptors);
  }

  static const _host = 'https://api.pub.dev';

  late final Dio _client;

  void _install(List<Interceptor> interceptors) {
    final options = BaseOptions(
      baseUrl: _host,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      contentType: ContentType.json.value,
    );

    final client = Dio(options);

    final logInterceptor = LogInterceptor(
      requestBody: true,
      responseBody: true,
    );

    final interceptorList = [logInterceptor, ...interceptors];

    for (var interceptor in interceptorList) {
      client.interceptors.add(interceptor);
    }

    _client = client;
  }

  @override
  Future<Map<String, dynamic>> get(
    String method,
    Map<String, dynamic> queryParameters,
  ) async {
    try {
      final response = await _client.get(method);
      return response.data;
    } on DioException catch (e) {
      throw _capture(e);
    }
  }

  @override
  Future<Map<String, dynamic>> post(
    String method,
    Map<String, dynamic> queryParameters,
  ) async {
    try {
      final response = await _client.get(method);
      return response.data;
    } on DioException catch (e) {
      throw _capture(e);
    }
  }

  ApiException _capture(DioException exception) {
    final response = exception.response;
    if (response == null) {
      switch (exception.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return ApiException(
            error: exception.message,
            stackTrace: exception.stackTrace,
            type: ApiExceptionType.timeout,
          );
        default:
          return ApiException(
            error: exception.message,
            stackTrace: exception.stackTrace,
            statusCode: 403,
            type: ApiExceptionType.other,
          );
      }
    } else if (response.statusCode == 401) {
      return ApiException(
        error: response.data,
        stackTrace: exception.stackTrace,
        statusCode: response.statusCode,
        type: ApiExceptionType.auth,
      );
    } else if (response.statusCode == 404) {
      return ApiException(
        error: response.data,
        stackTrace: exception.stackTrace,
        statusCode: response.statusCode,
        type: ApiExceptionType.badRequest,
      );
    } else {
      return ApiException(
        error: response.data,
        stackTrace: exception.stackTrace,
        statusCode: response.statusCode,
        type: ApiExceptionType.other,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> createPost(
    Map<String, dynamic> queryParameters,
  ) async {
    try {
      final response = await _client.get(ApiMethods.create);
      return response.data;
    } on DioException catch (e) {
      throw _capture(e);
    }
  }

  @override
  Future<Map<String, dynamic>> login(
    Map<String, dynamic> queryParameters,
  ) async {
    try {
      final response = await _client.get(ApiMethods.token);
      return response.data;
    } on DioException catch (e) {
      throw _capture(e);
    }
  }

  @override
  Future<Map<String, dynamic>> register(
    Map<String, dynamic> queryParameters,
  ) async {
    try {
      final response = await _client.get(ApiMethods.register);
      return response.data;
    } on DioException catch (e) {
      throw _capture(e);
    }
  }
}
