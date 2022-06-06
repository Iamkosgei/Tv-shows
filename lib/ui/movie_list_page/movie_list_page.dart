import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv_shows/blocs/logged_in_user_cubit/logged_in_user_cubit.dart';
import 'package:flutter_tv_shows/configs/colors.dart';
import 'package:flutter_tv_shows/data/repositories/auth_repository.dart';
import 'package:flutter_tv_shows/di/injector.dart';
import 'package:flutter_tv_shows/ui/movie_list_page/widgets/movies_list.dart';
import 'package:flutter_tv_shows/ui/movie_list_page/widgets/profile_bottom_sheet.dart';
import 'package:flutter_tv_shows/utils/constants.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoggedInUserCubit(
        authRepository: inject.get<AuthRepository>(),
      )..getLoggedInUser(),
      child: BlocBuilder<LoggedInUserCubit, LoggedInUserState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Shows',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        if (state is LoggedInUserLoaded)
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  builder: (_) => const ProfileBottomSheet(),
                                );
                              },
                              icon: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  state.user.imageUrl ?? defaultProfileAvatar,
                                ),
                              ))
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Expanded(child: MoviesList())
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
