import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/utils/constants.dart';
import 'package:flutter_tv_shows/utils/utils.dart';

part 'start_up_state.dart';

class StartUpCubit extends Cubit<StartUpState> {
  final SecureStorageHelper secureStorageHelper;
  StartUpCubit(this.secureStorageHelper) : super(StartUpInitial());

  Future<void> checkAuthStatus() async {
    try {
      var authStatus = await secureStorageHelper.getString(isLoggedIn);
      await Future.delayed(const Duration(seconds: 2));

      emit(AuthStatus(loggedIn: authStatus == 'true'));
    } catch (e) {
      emit(StartUpError('${getGlobalApplocalization()?.somethingWentWrong}'));
    }
  }
}
