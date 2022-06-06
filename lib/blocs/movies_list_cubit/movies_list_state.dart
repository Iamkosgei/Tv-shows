part of 'movies_list_cubit.dart';

abstract class MoviesListState extends Equatable {
  const MoviesListState();

  @override
  List<Object> get props => [];
}

class MoviesListInitial extends MoviesListState {}

class MoviesListLoading extends MoviesListState {
  final List<Show> movies;
  final bool isFirstFetch;

  const MoviesListLoading({required this.movies, required this.isFirstFetch});
}

class MoviesListError extends MoviesListState {
  final String message;
  final List<Show> movies;
  final bool isFirstFetch;

  const MoviesListError(
      {required this.message,
      required this.movies,
      required this.isFirstFetch});
}

class MoviesLoaded extends MoviesListState {
  final List<Show> movies;

  const MoviesLoaded(this.movies);
}
