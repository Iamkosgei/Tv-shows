import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tv_shows/data/network/interceptors/auth_interceptor.dart';
import 'package:flutter_tv_shows/utils/urls.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final AuthInterceptor authInterceptor;

  DioClient(
    this.authInterceptor,
  );
  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 50000,
      receiveTimeout: 30000,
    );
    Dio dio = Dio(options);

    dio.interceptors.add(authInterceptor);
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }

    return dio;
  }
}
