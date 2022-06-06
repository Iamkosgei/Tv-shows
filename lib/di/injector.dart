import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/data/network/interceptors/auth_interceptor.dart';
import 'package:flutter_tv_shows/data/repositories/auth_repository.dart';
import 'package:flutter_tv_shows/data/repositories/movies_repository.dart';
import 'package:flutter_tv_shows/services/navigation_service.dart';
import 'package:flutter_tv_shows/services/toast_service.dart';
import 'package:flutter_tv_shows/utils/urls.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

GetIt inject = GetIt.instance;

Future<void> setUpLocator() async {
  inject.registerSingleton<ToastService>(ToastService());

  inject.registerSingleton<SecureStorageHelper>(
    SecureStorageHelperImpl(
      flutterSecureStorage: const FlutterSecureStorage(),
    ),
  );
  inject.registerSingleton<NavigationService>(NavigationService());

  inject.registerLazySingleton<Dio>(() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 50000,
      receiveTimeout: 30000,
    );
    Dio dio = Dio(options);

    dio.interceptors.add(AuthInterceptor(
      secureStorageHelper: inject.get<SecureStorageHelper>(),
    ));
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
  });

  inject.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      dio: inject.get<Dio>(),
      secureStorageHelper: inject.get<SecureStorageHelper>(),
    ),
  );

  inject.registerSingleton<MoviesRepository>(
    MoviesRepositoryImpl(
      dio: inject.get<Dio>(),
    ),
  );
}
