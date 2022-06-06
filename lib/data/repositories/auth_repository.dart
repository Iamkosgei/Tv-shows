import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/data/models/error_response.dart';
import 'package:flutter_tv_shows/data/models/login_user_request.dart';
import 'package:flutter_tv_shows/data/models/login_user_success_response.dart';
import 'package:flutter_tv_shows/data/models/user.dart';
import 'package:flutter_tv_shows/data/models/user_session_data.dart';
import 'package:flutter_tv_shows/data/network/dio_exceptions.dart';
import 'package:flutter_tv_shows/utils/constants.dart';
import 'package:flutter_tv_shows/utils/urls.dart';

abstract class AuthRepository {
  Future<User> loginUser(LoginUserRequest loginUserRequest);
  Future<void> saveStringToSecuredHelper(String key, String value);
  Future<String?> getStringFromSecuredHelper(String key);
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final SecureStorageHelper secureStorageHelper;

  AuthRepositoryImpl({required this.dio, required this.secureStorageHelper});
  @override
  Future<User> loginUser(LoginUserRequest loginUserRequest) async {
    try {
      final res =
          await dio.post(userSignInUrl, data: loginUserRequest.toJson());
      if (res.statusCode != 201) {
        final error =
            ErrorResponse.fromJson(json.decode(json.encode(res.data)));
        throw Exception(error.errors?.join("\n"));
      }
      final user =
          LoginUserSuccessResponse.fromJson(json.decode(json.encode(res.data)))
              .user;
      if (user != null) {
        final resHeaders = res.headers;

        final userSessionData = UserSessionData(
          accessToken: resHeaders.value('access-token'),
          client: resHeaders.value('client'),
          tokenType: resHeaders.value('token-type'),
          uid: resHeaders.value('uid'),
        );

        await saveStringToSecuredHelper(
            userSessionDataKey, jsonEncode(userSessionData.toJson()));

        return user;
      } else {
        throw Exception('User not found');
      }
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> saveStringToSecuredHelper(String key, String value) async {
    return await secureStorageHelper.setString(key, value);
  }

  @override
  Future<String?> getStringFromSecuredHelper(String key) async {
    return await secureStorageHelper.getString(key);
  }
}
