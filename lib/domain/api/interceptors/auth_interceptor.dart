import 'package:dio/dio.dart';
import 'package:rugram/data/data_providers/token_data_provider.dart';

class AuthInterceptor extends Interceptor {
  final TokenDataProvider tokenDataProvider;

  AuthInterceptor(this.tokenDataProvider);
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenDataProvider.fetchToken();

    if (token == null) {
      super.onRequest(options, handler);
    } else {
      final opt = options.copyWith(headers: {'authorization': 'Token $token'});
      super.onRequest(opt, handler);
    }
  }
}
