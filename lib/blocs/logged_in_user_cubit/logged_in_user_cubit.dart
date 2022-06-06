import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv_shows/data/models/user.dart';
import 'package:flutter_tv_shows/data/repositories/auth_repository.dart';
import 'package:flutter_tv_shows/utils/constants.dart';

part 'logged_in_user_state.dart';

class LoggedInUserCubit extends Cubit<LoggedInUserState> {
  final AuthRepository authRepository;
  LoggedInUserCubit({required this.authRepository})
      : super(LoggedInUserInitial());

  Future<void> getLoggedInUser() async {
    try {
      emit(LoggedInUserLoading());

      final cachedUser =
          await authRepository.getStringFromSecuredHelper(loggedInUser);

      if (cachedUser != null) {
        final user = User.fromJson(jsonDecode(cachedUser));
        emit(LoggedInUserLoaded(user));
      } else {
        emit(LoggedInUserError());
      }
    } catch (e) {
      emit(LoggedInUserError());
    }
  }
}
