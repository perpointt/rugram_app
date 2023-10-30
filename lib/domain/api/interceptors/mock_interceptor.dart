import 'package:dio/dio.dart';

class MockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.resolve(
      Response(requestOptions: options, data: 'fake data'),
    );
  }
}
