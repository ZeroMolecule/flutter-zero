import 'package:dio/dio.dart';
import 'package:flutter_zero/gen/l10n.dart';

class ErrorParser {
  static String parse(Object? error) {
    final t = AppTranslations.current;
    String? result;
    if (error is DioError) {
      result = _parseDioError(error);
    } else if (error is String) {
      result = error;
    }
    return result ?? t.errorMessage;
  }

  static String? _parseDioError(DioError? error) {
    final data = error?.response?.data;
    if (data != null) {
      return _parseJsonError(data);
    } else {
      return _parseJsonError(error?.error);
    }
  }

  static String? _parseJsonError(dynamic error) {
    if (error is String) {
      return error;
    } else if (error is Map<String, dynamic>) {
      return _parseJsonError(error['message'] ??
          error['messages'] ??
          error['error'] ??
          error['data']);
    } else if (error is Iterable) {
      return _parseJsonError(error.first);
    }
  }
}
