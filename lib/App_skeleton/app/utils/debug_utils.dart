import 'dart:developer';
import 'package:flutter/foundation.dart';

import 'constants.dart';

class DebugUtils {
  static printAsdf(Object? string, {screen = ''}) {
    if (!kReleaseMode) {
      print('\x1B[36m$APP_NAME $screen ${string?.toString()}\x1B[0m');
    }
  }

  static printError(dynamic error, {StackTrace? stackTrace}) {
    if (kDebugMode) {
      print('\x1B[31;1m$APP_NAME $error\x1B[0m');
    }
    // FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  static printLog(String string) {
    if (!kReleaseMode) {
      log('\x1B[36m$APP_NAME $string\x1B[0m');
    }
  }
}
