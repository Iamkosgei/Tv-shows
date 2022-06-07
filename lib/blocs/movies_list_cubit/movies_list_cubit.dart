import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv_shows/data/models/shows_list_response.dart';
import 'package:flutter_tv_shows/data/repositories/movies_repository.dart';
import 'package:flutter_tv_shows/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'movies_list_state.dart';

class MoviesListCubit extends Cubit<MoviesListState> {
  int maxPage = 1;
  int page = 1;
  int itemsPerPage = 20;

  bool hasError = false;

  final MoviesRepository moviesRepository;
  MoviesListCubit({
    required this.moviesRepository,
  }) : super(MoviesListInitial());

  Future<void> getMovies() async {
    if (state is MoviesListLoading) return;

    //get current values
    List<Show> movies = [];

    try {
      if (state is MoviesLoaded) {
        movies = (state as MoviesLoaded).movies;
      } else if (state is MoviesListError) {
        movies = (state as MoviesListError).movies;
      }

      emit(MoviesListLoading(
        isFirstFetch: page == 1,
        movies: movies,
      ));

      final moviesResponse = await moviesRepository.getMovieList(page);
      if (moviesResponse.shows != null) {
        maxPage = moviesResponse.meta?.pagination?.pages ?? 1;

        //increment current page
        page++;

        //set error to false
        hasError = false;

        emit(MoviesLoaded([...movies, ...moviesResponse.shows!]));
      } else {
        hasError = true;
        emit(MoviesListError(
          message:
              '${AppLocalizations.of(getGlobalApplicationContext()!)?.somethingWentWrong}',
          isFirstFetch: page == 1,
          movies: movies,
        ));
      }
    } catch (e) {
      hasError = true;
      emit(MoviesListError(
          isFirstFetch: page == 1, message: '$e', movies: movies));
    }
  }

  void loadMore() {
    if (page <= maxPage && !hasError) {
      getMovies();
    }
  }
}
