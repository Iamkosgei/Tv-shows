import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv_shows/utils/validators.dart';

part 'login_form_validation_state.dart';

class LoginFormValidationCubit extends Cubit<LoginFormValidationState> {
  LoginFormValidationCubit()
      : super(const LoginFormValidationCurrentState(
            email: '',
            isEmailValid: false,
            isPasswordValid: false,
            password: ''));

  void validateEmail(String email) {
    final currentState = state as LoginFormValidationCurrentState;

    emit(LoginFormValidationCurrentState(
      email: email,
      isEmailValid: isEmailValid(email),
      isPasswordValid: currentState.isPasswordValid,
      password: currentState.password,
    ));
  }

  void validatePassword(String pass) {
    final currentState = state as LoginFormValidationCurrentState;

    emit(LoginFormValidationCurrentState(
      email: currentState.email,
      isEmailValid: currentState.isEmailValid,
      isPasswordValid: isPasswordValid(pass),
      password: pass,
    ));
  }
}
