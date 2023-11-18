import 'package:dio/dio.dart';
import 'package:rugram/data/data_providers/session_data_provider.dart';

class AuthInterceptor extends Interceptor {
  final SessionDataProvider sessionDataProvider;

  AuthInterceptor(this.sessionDataProvider);
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final session = await sessionDataProvider.fetchSession();
    final token = session?.token;
    if (token == null) {
      super.onRequest(options, handler);
    } else {
      final opt = options.copyWith(headers: {'authorization': 'Token $token'});
      super.onRequest(opt, handler);
    }
  }
}
