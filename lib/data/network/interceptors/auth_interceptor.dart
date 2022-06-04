import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/utils/constants.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageHelper secureStorageHelper;

  AuthInterceptor({required this.secureStorageHelper});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('signin') || options.path.contains('signup')) {
      handler.next(options);
    } else {
      var token = await secureStorageHelper.getString(accessToken);

      if (token != null) {
        options.headers[HttpHeaders.authorizationHeader] = token;
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
}
