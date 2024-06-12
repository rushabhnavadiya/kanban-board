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

    var start = '\x1b[90m';
    // const end = '\x1b[0m';
    const end = '';

    // const white = '\x1b[37m';

    switch (record.level.name) {
      case 'INFO':
        // start = '\x1b[92m';
        start = 'INFO: ';
        break;
      case 'WARNING':
        // start = '\x1b[93m';
        start = 'WARNING: ';
        break;
      case 'SEVERE':
        // start = '\x1b[103m\x1b[31m';
        start = 'SEVERE: ';
        break;
      case 'SHOUT':
        // start = '\x1b[41m\x1b[93m';
        start = 'SHOUT: ';
        break;
    }

    final message = '$end$start${record.message}$end';
    developer.log(
      message,
      // name: record.loggerName.padRight(25),
      level: record.level.value,
    );
  });
}