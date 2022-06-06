import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv_shows/blocs/movies_list_cubit/movies_list_cubit.dart';
import 'package:flutter_tv_shows/data/repositories/movies_repository.dart';
import 'package:flutter_tv_shows/di/injector.dart';
import 'package:flutter_tv_shows/ui/common_widgets/error_retry_view.dart';
import 'package:flutter_tv_shows/ui/movie_list_page/widgets/movie_item.dart';
import 'package:flutter_tv_shows/ui/movie_list_page/widgets/movie_list_loading_shimmer.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MoviesListCubit(moviesRepository: inject.get<MoviesRepository>())
            ..getMovies(),
      child: BlocBuilder<MoviesListCubit, MoviesListState>(
        builder: (context, state) {
          if (state is MoviesLoaded) {
            return ListView.separated(
                itemBuilder: (context, index) => MovieItem(
                      show: state.movies[index],
                    ),
                separatorBuilder: (_, __) => const SizedBox(
                      height: 4,
                    ),
                itemCount: state.movies.length);
          } else if (state is MoviesListLoading) {
            return const MovieListLoadingShimmer();
          } else if (state is MoviesListError) {
            return ErrorRetryView(
              error: state.error,
              onTapRetry: () {
                context.read<MoviesListCubit>().getMovies();
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
