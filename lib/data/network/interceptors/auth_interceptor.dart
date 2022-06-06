import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/data/models/user_session_data.dart';
import 'package:flutter_tv_shows/di/injector.dart';
import 'package:flutter_tv_shows/navigation/pages.dart';
import 'package:flutter_tv_shows/services/navigation_service.dart';
import 'package:flutter_tv_shows/utils/constants.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageHelper secureStorageHelper;

  AuthInterceptor({required this.secureStorageHelper});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('sign_in')) {
      handler.next(options);
    } else {
      final cachedUserData =
          await secureStorageHelper.getString(userSessionDataKey);

      if (cachedUserData != null) {
        final user = UserSessionData.fromJson(jsonDecode(cachedUserData));

        options.headers['access-token'] = user.accessToken;
        options.headers['client'] = user.client;
        options.headers['token-type'] = user.tokenType;
        options.headers['uid'] = user.uid;
      }

      handler.next(options);
    }
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    debugPrint('*** response ***');
    debugPrint(jsonEncode(response.data));
    debugPrint('*** response ***');
    return handler.next(response);
  }

  @override
  Future<void> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      if (!err.requestOptions.path.contains('sign_in')) {
        //can refresh token
        await secureStorageHelper.clearAll();
        inject.get<NavigationService>().clearAllRoutes(loginPage);
      }
    }
    return super.onError(err, handler);
  }
}
