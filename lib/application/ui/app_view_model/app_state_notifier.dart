import 'package:flutter/cupertino.dart';
import 'package:rugram/domain/models/app_exception.dart';
import 'app_state.dart';

class AppStateNotifier extends ChangeNotifier {
  AppState _state = InitialAppState();
  AppState get state => _state;

  void setState(AppState state) {
    if (_state == state) return;
    _state = state;
    notifyListeners();
  }

  void setStateByException(Object exception) {
    if (exception is ApiException) {
      switch (exception.type) {
        case ApiExceptionType.auth:
        case ApiExceptionType.other:
          setState(ApiErrorState(exception));
          break;
        case ApiExceptionType.badRequest:
          setState(BadRequestState(exception));
          break;
        case ApiExceptionType.timeout:
          setState(NoInternetState(exception));
          break;
      }
    } else {
      setState(InternalErrorState(exception));
    }
  }
}
