import 'package:dio/dio.dart';
import 'package:flutter_zero/gen/l10n.dart';

class ErrorParser {
  final AppTranslations _t;

  ErrorParser(this._t);

  String parse(Object? error) {
    String? result;
    if (error is DioError) {
      result = _parseDioError(error);
    } else if (error is String) {
      result = error;
    }
    return result ?? _t.errorMessage;
  }

  String? _parseDioError(DioError? error) {
    final data = error?.response?.data;
    if (data != null) {
      print(data);
      return _parseJsonError(data);
    } else {
      return _parseJsonError(error?.error);
    }
  }

  String? _parseJsonError(dynamic error) {
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
