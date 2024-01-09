
import 'package:logger/logger.dart';

class TLoggerHelper {
  final _logger = Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );

  void debug(String message) {
    _logger.d(message);
  }

  void info(String message) {
    _logger.i(message);
  }

  void error(String message) {
    _logger.e(message);
  }

  void warning(String message) {
    _logger.w(message);
  }
}
