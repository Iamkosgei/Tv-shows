part of 'start_up_cubit.dart';

@immutable
abstract class StartUpState {
  const StartUpState();
}

class StartUpInitial extends StartUpState {}

class AuthStatus extends StartUpState {
  final bool loggedIn;

  const AuthStatus({this.loggedIn = false});
}

class StartUpError extends StartUpState {
  final String error;

  const StartUpError(this.error);
}
