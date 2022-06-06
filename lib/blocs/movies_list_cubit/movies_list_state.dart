part of 'movies_list_cubit.dart';

abstract class MoviesListState extends Equatable {
  const MoviesListState();

  @override
  List<Object> get props => [];
}

class MoviesListInitial extends MoviesListState {}

class MoviesListLoading extends MoviesListState {}

class MoviesListError extends MoviesListState {
  final String error;

  const MoviesListError(this.error);
}

class MoviesLoaded extends MoviesListState {
  final List<Show> movies;

  const MoviesLoaded(this.movies);
}
