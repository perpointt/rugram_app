import 'dart:async';

abstract class ExceptionService {
  Future<void> start();

  Future<void> capture(Object error, StackTrace? stackTrace);

  FutureOr<void> markLaunchCompleted();
}
