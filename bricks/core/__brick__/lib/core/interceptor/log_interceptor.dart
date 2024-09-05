// Package imports:
import 'dart:convert';

import 'package:dio/dio.dart';
import '../logger.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var timestamp = "${DateTime.now().millisecondsSinceEpoch}";
    options.headers["timestamp"] = timestamp;

    Log.i("""--> 
    START REQUEST
    ${options.method} ${options.baseUrl}${options.path} 
    Content type: ${options.contentType}
    QueryParameters : ${options.queryParameters}
    Headers : ${options.headers}
    Data : ${_printData(options.data)}
    <-- END REQUEST""", tag: timestamp);
    return super.onRequest(options, handler);
  }

  String? _printData(dynamic data) {
    if (data == null) {
      return null;
    }
    if (data is FormData) {
      return data.fields.toString();
    }
    if (data is Map) {
      return const JsonEncoder.withIndent('  ').convert(data).toString();
    }
    if (data is List) {
      return const JsonEncoder.withIndent('  ').convert(data).toString();
    }
    return data.toString();
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //Time ${DateTime.now().millisecondsSinceEpoch - int.parse(response.requestOptions.headers["timestamp"])} ms
    Log.d("""--> 
    START RESPONSE
    Time ${DateTime.now().millisecondsSinceEpoch - int.parse(response.requestOptions.headers["timestamp"])} ms
    ${response.requestOptions.method} - ${response.requestOptions.baseUrl}${response.requestOptions.path} - ${response.statusCode}
    ${_printData(response.data)}
    <-- END RESPONSE""",
        tag: response.requestOptions.headers["timestamp"].toString());

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Log.e("""--> 
    START ERROR
    ${err.type}
    ${err.requestOptions.method} - ${err.requestOptions.baseUrl}${err.requestOptions.path} - ${err.response?.statusCode}
    ${err.requestOptions.headers}
    ${err.requestOptions.data}
    ${_printData(err.response?.data)}
    <-- END ERROR""", tag: err.requestOptions.headers["timestamp"].toString());

    return super.onError(err, handler);
  }
}
