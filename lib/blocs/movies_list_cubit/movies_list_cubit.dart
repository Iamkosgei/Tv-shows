import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv_shows/data/models/shows_list_response.dart';
import 'package:flutter_tv_shows/data/repositories/movies_repository.dart';

part 'movies_list_state.dart';

class MoviesListCubit extends Cubit<MoviesListState> {
  int page = 1;
  final MoviesRepository moviesRepository;
  MoviesListCubit({
    required this.moviesRepository,
  }) : super(MoviesListInitial());

  Future<void> getMovies() async {
    try {
      emit(MoviesListLoading());
      final movies = await moviesRepository.getMovieList(page);
      if (movies.shows != null) {
        emit(MoviesLoaded(movies.shows!));
      } else {
        emit(const MoviesListError('Something went wrong'));
      }
    } catch (e) {
      emit(MoviesListError('$e'));
    }
  }
}
