import 'dart:io';
import 'package:dio/dio.dart';
import 'package:knaw_news/mixin/data.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
export 'package:dio/dio.dart';



final defaultDio=Dio(BaseOptions())..interceptors.addAll([
  InterceptorsWrapper(onRequest: (options, handler) async {
    final _appData = AppData();
    if (_appData.accessToken.isNotEmpty) {
      options.headers[HttpHeaders.authorizationHeader] =
      "Bearer ${_appData.accessToken}";
    }
    return handler.next(options);
  }),PrettyDioLogger(requestBody: true, requestHeader: true,)
]);

