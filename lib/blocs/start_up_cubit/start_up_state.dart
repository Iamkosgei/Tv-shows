part of 'start_up_cubit.dart';

@immutable
abstract class StartUpState extends Equatable {
  const StartUpState();
}

class StartUpInitial extends StartUpState {
  @override
  List<Object?> get props => [];
}

class AuthStatus extends StartUpState {
  final bool loggedIn;

  const AuthStatus({this.loggedIn = false});

  @override
  List<Object?> get props => [loggedIn];
}

class StartUpError extends StartUpState {
  final String error;

  const StartUpError(this.error);

  @override
  List<Object?> get props => [error];
}
