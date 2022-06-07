import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/data/repositories/auth_repository.dart';
import 'package:flutter_tv_shows/utils/constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';
import 'auth_repository_test_data.dart';

@GenerateMocks([Dio, SecureStorageHelper])
void main() {
  late MockDio dio;
  late MockSecureStorageHelper secureStorageHelper;
  late AuthRepositoryImpl authRepositoryImpl;

  setUp(() {
    dio = MockDio();
    secureStorageHelper = MockSecureStorageHelper();
    authRepositoryImpl =
        AuthRepositoryImpl(dio: dio, secureStorageHelper: secureStorageHelper);
  });

  test(
      'loginUser() returns a user when authentication is successful and user is not null',
      () async {
    when(secureStorageHelper.setString(userSessionDataKey, ""))
        .thenAnswer((_) async => Future.value());

    when(dio.post('users/sign_in', data: loginUser.toJson())).thenAnswer(
      (_) async => Future.value(
        Response(
          statusCode: 201,
          headers: Headers()
            ..add('access-token', 'access-token')
            ..add('client', 'client')
            ..add('token-type', 'token-type')
            ..add('uid', 'uid'),
          data: successUserLoginResponse,
          requestOptions: RequestOptions(path: 'users/sign_in'),
        ),
      ),
    );

    final response = await authRepositoryImpl.loginUser(loginUser);

    expect(response, user);

    verify(secureStorageHelper.setString(
            userSessionDataKey, jsonEncode(userSessionData.toJson())))
        .called(1);

    verify(dio.post('users/sign_in', data: loginUser.toJson())).called(1);
  });

  test('loginUser() throws an exception when login request is not successful',
      () async {
    WidgetsFlutterBinding.ensureInitialized();
    when(secureStorageHelper.setString(userSessionDataKey, ""))
        .thenAnswer((_) async => Future.value());

    when(dio.post('users/sign_in', data: loginUser.toJson())).thenThrow(
      DioError(
        type: DioErrorType.response,
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: 'users/sign_in'),
        ),
        error: errorUserLoginResponse,
        requestOptions: RequestOptions(path: 'users/sign_in'),
      ),
    );
    expect(
        () => authRepositoryImpl.loginUser(loginUser),
        throwsA(
            'Invalid credentials,Please check username and password and try again'));

    verify(dio.post('users/sign_in', data: loginUser.toJson())).called(1);
  });

  test(
      'getStringFromSecuredHelper returns the stored string from secured helper',
      () async {
    when(secureStorageHelper.getString(loggedInUser))
        .thenAnswer((_) async => Future.value("Stored str"));

    final storedStr =
        await authRepositoryImpl.getStringFromSecuredHelper(loggedInUser);

    expect(storedStr, "Stored str");
    verify(secureStorageHelper.getString(loggedInUser)).called(1);
  });

  test('saveStringToSecuredHelper saves String to secured storage', () async {
    when(secureStorageHelper.setString(loggedInUser, "Stored str"))
        .thenAnswer((_) async => Future.value());

    when(secureStorageHelper.getString(loggedInUser))
        .thenAnswer((_) async => Future.value("Stored str"));

    await authRepositoryImpl.saveStringToSecuredHelper(
        loggedInUser, "Stored str");

    final storedStr = await secureStorageHelper.getString(loggedInUser);

    expect(storedStr, "Stored str");
    verify(secureStorageHelper.getString(loggedInUser)).called(1);
  });
}
