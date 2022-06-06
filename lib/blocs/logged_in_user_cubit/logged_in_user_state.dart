part of 'logged_in_user_cubit.dart';

abstract class LoggedInUserState extends Equatable {
  const LoggedInUserState();

  @override
  List<Object> get props => [];
}

class LoggedInUserInitial extends LoggedInUserState {}

class LoggedInUserLoading extends LoggedInUserState {}

class LoggedInUserLoaded extends LoggedInUserState {
  final User user;

  const LoggedInUserLoaded(this.user);
}

class LoggedInUserError extends LoggedInUserState {}
