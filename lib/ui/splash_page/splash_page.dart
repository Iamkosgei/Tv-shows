import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tv_shows/blocs/start_up_cubit/start_up_cubit.dart';
import 'package:flutter_tv_shows/configs/assets.dart';
import 'package:flutter_tv_shows/configs/colors.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/di/injector.dart';
import 'package:flutter_tv_shows/navigation/pages.dart';
import 'package:flutter_tv_shows/services/navigation_service.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StartUpCubit(inject.get<SecureStorageHelper>())..checkAuthStatus(),
      child: Scaffold(
        backgroundColor: primaryColor,
        body: BlocListener<StartUpCubit, StartUpState>(
          listener: (context, state) {
            if (state is AuthStatus) {
              inject.get<NavigationService>().navigateTo(
                  state.loggedIn ? movieListPage : loginPage,
                  clearBackStack: true);
            }
          },
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: SvgPicture.asset(Assets.imgTopLeft),
              ),
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(Assets.imgTopRight),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(Assets.imgBottomRight),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: SvgPicture.asset(Assets.imgBottomLeft),
              ),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(Assets.imgLoginLogo),
              )
            ],
          ),
        ),
      ),
    );
  }
}
