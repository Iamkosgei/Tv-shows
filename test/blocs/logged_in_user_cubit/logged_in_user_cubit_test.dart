import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_shows/blocs/logged_in_user_cubit/logged_in_user_cubit.dart';
import 'package:flutter_tv_shows/data/repositories/auth_repository.dart';
import 'package:flutter_tv_shows/utils/constants.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logged_in_user_cubit_test.mocks.dart';
import 'logged_in_user_data.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;

  late LoggedInUserCubit loggedInUserCubit;

  tearDownAll(() {
    loggedInUserCubit.close();
  });

  setUp(() async {
    mockAuthRepository = MockAuthRepository();

    loggedInUserCubit = LoggedInUserCubit(
      authRepository: mockAuthRepository,
    );
  });

  test('logged in user cubit initial state should be [LoggedInUserInitial]',
      () {
    expect(loggedInUserCubit.state.runtimeType, LoggedInUserInitial);
  });

  blocTest(
    'emits [LoggedInUserLoading, LoggedInUserLoaded] when getLoggedInUser is called user is returned successfully',
    build: () {
      when(mockAuthRepository.getStringFromSecuredHelper(loggedInUser))
          .thenAnswer(
        (_) async => Future.value(
          userStr,
        ),
      );

      return loggedInUserCubit;
    },
    act: (LoggedInUserCubit cubit) => cubit.getLoggedInUser(),
    expect: () => [
      LoggedInUserLoading(),
      const LoggedInUserLoaded(user),
    ],
  );

  blocTest(
    'emits [LoggedInUserLoading, LoggedInUserError] when getLoggedInUser is called user is null',
    build: () {
      when(mockAuthRepository.getStringFromSecuredHelper(loggedInUser))
          .thenAnswer(
        (_) async => Future.value(
          null,
        ),
      );

      return loggedInUserCubit;
    },
    act: (LoggedInUserCubit cubit) => cubit.getLoggedInUser(),
    expect: () => [
      LoggedInUserLoading(),
      LoggedInUserError(),
    ],
  );

  blocTest(
    'emits [LoggedInUserLoading, LoggedInUserError] when getLoggedInUser is called and exception is thrown',
    build: () {
      when(mockAuthRepository.getStringFromSecuredHelper(loggedInUser))
          .thenThrow(Exception());

      return loggedInUserCubit;
    },
    act: (LoggedInUserCubit cubit) => cubit.getLoggedInUser(),
    expect: () => [
      LoggedInUserLoading(),
      LoggedInUserError(),
    ],
  );
}
