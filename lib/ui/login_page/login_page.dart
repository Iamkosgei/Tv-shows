import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tv_shows/blocs/login_cubit/login_cubit.dart';
import 'package:flutter_tv_shows/blocs/login_form_validation/login_form_validation_cubit.dart';
import 'package:flutter_tv_shows/configs/assets.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/data/repositories/auth_repository.dart';
import 'package:flutter_tv_shows/di/injector.dart';
import 'package:flutter_tv_shows/navigation/pages.dart';
import 'package:flutter_tv_shows/services/navigation_service.dart';
import 'package:flutter_tv_shows/services/toast_service.dart';
import 'package:flutter_tv_shows/ui/common_widgets/primary_text_form_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginFormValidationCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
            authRepository: inject.get<AuthRepository>(),
            secureStorageHelper: inject.get<SecureStorageHelper>(),
          ),
        ),
      ],
      child: BlocBuilder<LoginFormValidationCubit, LoginFormValidationState>(
        builder: (context, state) {
          return state is LoginFormValidationCurrentState
              ? Scaffold(
                  body: SingleChildScrollView(
                    child: BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, loginState) {
                        if (loginState is LoginError) {
                          inject.get<ToastService>().showErrorToast(
                                loginState.error,
                              );
                        } else if (loginState is LoginSuccess) {
                          inject.get<NavigationService>().navigateTo(
                                movieListPage,
                                clearBackStack: true,
                              );

                          inject.get<ToastService>().showSuccessToast(
                                loginState.message,
                              );
                        }
                      },
                      builder: (context, loginState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SvgPicture.asset(Assets.imgTopLeft),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SizedBox(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                              Assets.imgLoginLogo),
                                        ),
                                      ),
                                      SvgPicture.asset(Assets.imgTopRight),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)?.login ??
                                        'Login',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .loginRequirement,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  PrimaryTextFormField(
                                    labelText:
                                        AppLocalizations.of(context)!.email,
                                    onChanged: (String? val) {
                                      context
                                          .read<LoginFormValidationCubit>()
                                          .validateEmail(val ?? '');
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  PrimaryTextFormField(
                                    labelText:
                                        AppLocalizations.of(context)!.password,
                                    obscureText: true,
                                    onChanged: (String? val) {
                                      context
                                          .read<LoginFormValidationCubit>()
                                          .validatePassword(val ?? '');
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .createAccount,
                                        )),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  if (loginState is LoginLoading)
                                    const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  ElevatedButton(
                                      onPressed: state.isEmailValid &&
                                              state.isPasswordValid
                                          ? () {
                                              if (loginState is LoginLoading) {
                                                return;
                                              }

                                              context
                                                  .read<LoginCubit>()
                                                  .loginUser(
                                                    state.email,
                                                    state.password,
                                                  );
                                            }
                                          : null,
                                      child: const Text('Login')),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
