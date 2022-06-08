import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_shows/blocs/login_cubit/login_cubit.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/data/models/login_user_request.dart';
import 'package:flutter_tv_shows/data/models/user.dart';
import 'package:flutter_tv_shows/data/repositories/auth_repository.dart';
import 'package:flutter_tv_shows/utils/constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'login_cubit_mock_data.dart';
import 'login_cubit_test.mocks.dart';

@GenerateMocks([AuthRepository, SecureStorageHelper])
void main() {
  late MockAuthRepository mockAuthRepository;
  late MockSecureStorageHelper mockSecureStorageHelper;

  late LoginCubit loginCubit;

  tearDownAll(() {
    loginCubit.close();
  });

  setUp(() async {
    mockAuthRepository = MockAuthRepository();
    mockSecureStorageHelper = MockSecureStorageHelper();

    loginCubit = LoginCubit(
      authRepository: mockAuthRepository,
      secureStorageHelper: mockSecureStorageHelper,
    );
  });

  test('login cubit initial state should be [LoginInitial]', () {
    expect(loginCubit.state.runtimeType, LoginInitial);
  });

  blocTest(
    'emits [LoginLoading, LoginSuccess] when loginUser is called and user is logged in successfully',
    build: () {
      when(mockAuthRepository.loginUser(
        const LoginUserRequest(
          email: 'testemail@user.com',
          password: '1234',
        ),
      )).thenAnswer(
        (_) async => Future.value(
          const User(
              email: 'testemail@user.com', id: '1', imageUrl: 'test.png'),
        ),
      );

      when(mockAuthRepository.saveStringToSecuredHelper(isLoggedIn, 'true'))
          .thenAnswer(
        (_) async => Future.value(),
      );

      when(mockAuthRepository.saveStringToSecuredHelper(
              loggedInUser, jsonEncode(user.toJson())))
          .thenAnswer(
        (_) async => Future.value(),
      );

      return loginCubit;
    },
    act: (LoginCubit cubit) => cubit.loginUser('testemail@user.com', '1234'),
    expect: () => [
      LoginLoading(),
      const LoginSuccess('Login success, welcome.'),
    ],
  );

  blocTest(
    'emits [LoginLoading, LoginError] when loginUser is called and an exception is thrown',
    build: () {
      when(mockAuthRepository.loginUser(
        const LoginUserRequest(
          email: 'testemail@user.com',
          password: '1234',
        ),
      )).thenThrow(Exception('Something went wrong'));

      return loginCubit;
    },
    act: (LoginCubit cubit) => cubit.loginUser('testemail@user.com', '1234'),
    expect: () => [
      LoginLoading(),
      const LoginError('Something went wrong'),
    ],
  );
}
