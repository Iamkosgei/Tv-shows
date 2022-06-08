import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/data/models/login_user_request.dart';
import 'package:flutter_tv_shows/data/repositories/auth_repository.dart';
import 'package:flutter_tv_shows/utils/constants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  final SecureStorageHelper secureStorageHelper;
  LoginCubit({
    required this.secureStorageHelper,
    required this.authRepository,
  }) : super(LoginInitial());

  Future<void> loginUser(String email, String password) async {
    try {
      emit(LoginLoading());
      final res = await authRepository.loginUser(
        LoginUserRequest(
          email: email,
          password: password,
        ),
      );
      await authRepository.saveStringToSecuredHelper(isLoggedIn, 'true');
      await authRepository.saveStringToSecuredHelper(
          loggedInUser, jsonEncode(res.toJson()));

      emit(const LoginSuccess('Login success, welcome.'));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
