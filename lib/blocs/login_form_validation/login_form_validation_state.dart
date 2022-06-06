part of 'login_form_validation_cubit.dart';

abstract class LoginFormValidationState extends Equatable {
  const LoginFormValidationState();

  @override
  List<Object> get props => [];
}

class LoginFormValidationCurrentState extends LoginFormValidationState {
  final String email;
  final bool isEmailValid;
  final String password;
  final bool isPasswordValid;

  const LoginFormValidationCurrentState({
    required this.email,
    required this.isEmailValid,
    required this.password,
    required this.isPasswordValid,
  });

  @override
  List<Object> get props => [email, isEmailValid, password, isPasswordValid];
}
