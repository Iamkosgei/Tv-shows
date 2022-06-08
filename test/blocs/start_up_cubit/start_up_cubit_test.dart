import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_shows/blocs/start_up_cubit/start_up_cubit.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/utils/constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'start_up_cubit_test.mocks.dart';

@GenerateMocks([SecureStorageHelper])
void main() {
  late MockSecureStorageHelper mockSecureStorageHelper;

  late StartUpCubit startUpCubit;

  tearDownAll(() {
    startUpCubit.close();
  });

  setUp(() async {
    mockSecureStorageHelper = MockSecureStorageHelper();

    startUpCubit = StartUpCubit(mockSecureStorageHelper);
  });

  test('start up cubit initial state should be [StartUpInitial]', () {
    expect(startUpCubit.state.runtimeType, StartUpInitial);
  });

  blocTest(
    'emits [AuthStatus, true] when checkAuthStatus is called and user is logged in already',
    build: () {
      when(mockSecureStorageHelper.getString(isLoggedIn))
          .thenAnswer((_) async => Future.value('true'));

      return startUpCubit;
    },
    act: (StartUpCubit cubit) => cubit.checkAuthStatus(),
    expect: () => [const AuthStatus(loggedIn: true)],
  );

  blocTest(
    'emits [AuthStatus, false] when checkAuthStatus is called and user is logged in already',
    build: () {
      when(mockSecureStorageHelper.getString(isLoggedIn))
          .thenAnswer((_) async => Future.value('false'));

      return startUpCubit;
    },
    act: (StartUpCubit cubit) => cubit.checkAuthStatus(),
    expect: () => [const AuthStatus(loggedIn: false)],
  );

  blocTest(
    'emits [AuthStatus, false] when sharedhelper throws an error',
    build: () {
      when(mockSecureStorageHelper.getString(isLoggedIn))
          .thenThrow('Something went wrong');

      return startUpCubit;
    },
    act: (StartUpCubit cubit) => cubit.checkAuthStatus(),
    expect: () => [const StartUpError('Something went wrong')],
  );
}
