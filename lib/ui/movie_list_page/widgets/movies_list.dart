import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv_shows/blocs/movies_list_cubit/movies_list_cubit.dart';
import 'package:flutter_tv_shows/configs/colors.dart';
import 'package:flutter_tv_shows/data/repositories/movies_repository.dart';
import 'package:flutter_tv_shows/di/injector.dart';
import 'package:flutter_tv_shows/ui/common_widgets/error_retry_view.dart';
import 'package:flutter_tv_shows/ui/movie_list_page/widgets/movie_item.dart';
import 'package:flutter_tv_shows/ui/movie_list_page/widgets/movie_list_loading_shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  State<MoviesList> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MoviesListCubit(moviesRepository: inject.get<MoviesRepository>())
            ..getMovies(),
      child: BlocBuilder<MoviesListCubit, MoviesListState>(
        builder: (context, state) {
          if (state is MoviesListLoading && state.isFirstFetch) {
            return const MovieListLoadingShimmer();
          }

          if (state is MoviesListError && state.isFirstFetch) {
            return ErrorRetryView(
              error: state.message,
              onTapRetry: () {
                context.read<MoviesListCubit>().getMovies();
              },
            );
          }

          if (state is MoviesLoaded ||
              (state is MoviesListLoading && !state.isFirstFetch) ||
              (state is MoviesListError && !state.isFirstFetch)) {
            var movies = [];

            bool isLoadingMore = false;
            bool hasErrorLoadingMore = false;
            if (state is MoviesLoaded) {
              movies = state.movies;
            } else if (state is MoviesListLoading) {
              movies = state.movies;
              isLoadingMore = true;
            } else if (state is MoviesListError) {
              movies = state.movies;
              hasErrorLoadingMore = true;
            }

            return ListView.separated(
                controller: scrollController
                  ..addListener(() {
                    if (scrollController.position.pixels ==
                        scrollController.position.maxScrollExtent) {
                      context.read<MoviesListCubit>().loadMore();
                    }
                  }),
                itemBuilder: (context, index) {
                  if (index < movies.length) {
                    return MovieItem(
                      show: movies[index],
                    );
                  } else {
                    Timer(const Duration(milliseconds: 30), () {
                      scrollController
                          .jumpTo(scrollController.position.maxScrollExtent);
                    });

                    if (isLoadingMore) {
                      return Container(
                          height: 40,
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ));
                    } else if (hasErrorLoadingMore) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Divider(
                              color: primaryColor,
                            ),
                            Text(
                              state is MoviesListError ? state.message : '',
                              style: const TextStyle(
                                color: primaryColor,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<MoviesListCubit>().getMovies();
                              },
                              child: Text(
                                '${AppLocalizations.of(context)?.retry}',
                                style: const TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }
                },
                separatorBuilder: (_, __) => const SizedBox(
                      height: 4,
                    ),
                itemCount: movies.length +
                    (isLoadingMore || hasErrorLoadingMore ? 1 : 0));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
