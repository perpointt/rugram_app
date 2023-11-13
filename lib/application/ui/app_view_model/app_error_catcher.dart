import 'package:rugram/domain/models/app_exception.dart';
import 'package:rugram/domain/services/exception_service.dart';

typedef CaptureFunc<T> = T Function(ApiException);

mixin class AppErrorCatcher {
  static final _service = ExceptionServiceImpl();

  void captureExcepton<T>({
    required Object error,
    StackTrace? stackTrace,
    CaptureFunc<T>? onAuthException,
  }) {
    _service.capture(error, stackTrace);

    if (error is ApiException) {
      switch (error.type) {
        case ApiExceptionType.auth:
          onAuthException?.call(error);
          break;
        default:
          break;
      }
    }
  }
}
