import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

Logger logger = Logger("App Logger");

void initRootLogger() {
  // only enable logging for debug mode
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
  } else {
    Logger.root.level = Level.OFF;
  }
  hierarchicalLoggingEnabled = true;

  Logger.root.onRecord.listen((record) {
    if (!kDebugMode) {
      return;
    }
    /// Can Modify the log message from here.
    developer.log(
      record.message,
      // name: record.loggerName.padRight(25),
      level: record.level.value,
    );
  });
}
