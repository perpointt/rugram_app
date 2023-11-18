import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:rugram/domain/api/api_methods.dart';
import 'package:rugram/resources/resources.dart';

class MockInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    switch (options.path) {
      case ApiMethods.register:
        final response = await _loadAsset(MockResources.register);
        return handler.resolve(
          Response(requestOptions: options, data: response),
        );
      case ApiMethods.token:
        final response = await _loadAsset(MockResources.getToken);
        return handler.resolve(
          Response(requestOptions: options, data: response),
        );
      case ApiMethods.postCreate:
        final response = await _loadAsset(MockResources.createPost);
        return handler.resolve(
          Response(requestOptions: options, data: response),
        );
    }
  }

  Future<Map<String, dynamic>> _loadAsset(String asset) async {
    final data = await rootBundle.loadString(asset);
    return convert.jsonDecode(data) as Map<String, dynamic>;
  }
}
