import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;

class MockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.resolve(
      Response(requestOptions: options, data: 'fake data'),
    );
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/my_text.txt');
  }
}
