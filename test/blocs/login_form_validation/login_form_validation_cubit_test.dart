import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_shows/blocs/login_form_validation/login_form_validation_cubit.dart';

void main() {
  late LoginFormValidationCubit loginFormValidationCubit;

  tearDownAll(() {
    loginFormValidationCubit.close();
  });

  setUp(() async {
    loginFormValidationCubit = LoginFormValidationCubit();
  });
  test(
      'login form validation initial state should be [LoginFormValidationCurrentState]',
      () {
    expect(loginFormValidationCubit.state.runtimeType,
        LoginFormValidationCurrentState);
  });

  blocTest(
    'emits [LoginFormValidationCurrentState] with email as valid when validateEmail is called with a valid email',
    build: () {
      return loginFormValidationCubit;
    },
    act: (LoginFormValidationCubit cubit) =>
        cubit.validateEmail('kelvin@gmail.com'),
    expect: () => [
      const LoginFormValidationCurrentState(
          email: 'kelvin@gmail.com',
          isEmailValid: true,
          isPasswordValid: false,
          password: '')
    ],
  );

  blocTest(
    'emits [LoginFormValidationCurrentState] with email validity as false when validateEmail is called with a invalid email',
    build: () {
      return loginFormValidationCubit;
    },
    act: (LoginFormValidationCubit cubit) => cubit.validateEmail('kelvin'),
    expect: () => [
      const LoginFormValidationCurrentState(
          email: 'kelvin',
          isEmailValid: false,
          isPasswordValid: false,
          password: '')
    ],
  );

  blocTest(
    'emits [LoginFormValidationCurrentState] with password validity as true when validatePassword is called and password is not empty',
    build: () {
      return loginFormValidationCubit;
    },
    act: (LoginFormValidationCubit cubit) => cubit.validatePassword('123456'),
    expect: () => [
      const LoginFormValidationCurrentState(
          email: '',
          isEmailValid: false,
          isPasswordValid: true,
          password: '123456')
    ],
  );

  blocTest(
    'emits [LoginFormValidationCurrentState] with password validity as false when validatePassword is called and password is empty',
    build: () {
      return loginFormValidationCubit;
    },
    act: (LoginFormValidationCubit cubit) => cubit.validatePassword(''),
    expect: () => [
      const LoginFormValidationCurrentState(
        email: '',
        isEmailValid: false,
        isPasswordValid: false,
        password: '',
      )
    ],
  );
}
