import 'dart:async';
import 'dart:developer';

import 'package:bugsnag_flutter/bugsnag_flutter.dart';
import 'package:flutter/material.dart';
import 'package:rugram/data/servies/exception_service.dart';
import 'package:rugram/resources/resources.dart';

class ExceptionServiceImpl implements ExceptionService {
  @override
  Future<void> start() async {
    if (AppConfig.isDebug) return;

    await bugsnag.start(apiKey: AppConfig.bugsnagKey);
    FlutterError.onError = (details) {
      capture(details.exception, details.stack);
    };
  }

  @override
  Future<void> capture(Object error, StackTrace? stackTrace) async {
    if (AppConfig.isDebug) {
      log('$error\n$stackTrace');
    } else {
      return bugsnag.notify(error, stackTrace);
    }
  }

  @override
  FutureOr<void> markLaunchCompleted() {
    if (AppConfig.isProduction) return bugsnag.markLaunchCompleted();
    return null;
  }
}
