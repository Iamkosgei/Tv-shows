import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_shows/blocs/movies_list_cubit/movies_list_cubit.dart';
import 'package:flutter_tv_shows/data/models/shows_list_response.dart';
import 'package:flutter_tv_shows/data/repositories/movies_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movies_list_cubit_mock_data.dart';
import 'movies_list_cubit_test.mocks.dart';

@GenerateMocks([MoviesRepository])
void main() {
  late MockMoviesRepository mockMoviesRepository;

  late MoviesListCubit moviesListCubit;

  tearDownAll(() {
    moviesListCubit.close();
  });

  setUp(() async {
    mockMoviesRepository = MockMoviesRepository();

    moviesListCubit = MoviesListCubit(
      moviesRepository: mockMoviesRepository,
    );
  });

  test('movies list cubit initial state should be [MoviesListInitial]', () {
    expect(moviesListCubit.state.runtimeType, MoviesListInitial);
  });

  blocTest(
    'getmovies() emits no state when called and current state is MoviesListLoading ',
    build: () {
      moviesListCubit
          .emit(const MoviesListLoading(isFirstFetch: false, movies: []));

      return moviesListCubit;
    },
    act: (MoviesListCubit cubit) => cubit.getMovies(),
    expect: () => [],
  );

  blocTest(
    'emits [MoviesListLoading, MoviesLoaded] when getMovies() is called and movies are fetched successfully',
    build: () {
      when(mockMoviesRepository.getMovieList(1)).thenAnswer(
        (_) async => Future.value(showListReponse),
      );

      return moviesListCubit;
    },
    act: (MoviesListCubit cubit) => cubit.getMovies(),
    expect: () => [
      MoviesListLoading(
        isFirstFetch: true,
        movies: showListReponse.shows ?? [],
      ),
      MoviesLoaded(
        showListReponse.shows ?? [],
      )
    ],
  );

  blocTest(
    'emits [MoviesListLoading, MoviesListError] when getMovies() is called and an error occurs',
    build: () {
      when(mockMoviesRepository.getMovieList(1)).thenThrow(
        Exception('Something went wrong'),
      );

      return moviesListCubit;
    },
    act: (MoviesListCubit cubit) => cubit.getMovies(),
    expect: () => [
      const MoviesListLoading(
        isFirstFetch: true,
        movies: [],
      ),
      const MoviesListError(
          isFirstFetch: true, movies: [], message: 'Something went wrong')
    ],
  );

  blocTest(
    'emits [MoviesListLoading, MoviesLoaded] with more movies when getMovies() is called and the current state is MoviesLoaded',
    build: () {
      when(mockMoviesRepository.getMovieList(1)).thenAnswer(
        (_) async => Future.value(showListReponse),
      );

      moviesListCubit.emit(MoviesLoaded(showListReponse.shows ?? []));

      return moviesListCubit;
    },
    act: (MoviesListCubit cubit) => cubit.getMovies(),
    expect: () => [
      const MoviesListLoading(
        isFirstFetch: true,
        movies: [],
      ),
      MoviesLoaded(
        [...showListReponse.shows!, ...showListReponse.shows!],
      )
    ],
  );

  blocTest(
    'emits [MoviesListLoading, MoviesLoaded] with more movies when getMovies() is called and the current state is MoviesListError with movies',
    build: () {
      when(mockMoviesRepository.getMovieList(1)).thenAnswer(
        (_) async => Future.value(showListReponse),
      );

      moviesListCubit.emit(MoviesListError(
        isFirstFetch: false,
        message: 'Something went wrong',
        movies: showListReponse.shows ?? [],
      ));

      return moviesListCubit;
    },
    act: (MoviesListCubit cubit) => cubit.getMovies(),
    expect: () => [
      const MoviesListLoading(
        isFirstFetch: true,
        movies: [],
      ),
      MoviesLoaded(
        [...showListReponse.shows!, ...showListReponse.shows!],
      )
    ],
  );

  blocTest(
    'emits [MoviesListError] when getMovies() is called and shows is null',
    build: () {
      when(mockMoviesRepository.getMovieList(1)).thenAnswer(
        (_) async {
          return ShowsListResponse(shows: null, meta: showListReponse.meta);
        },
      );

      return moviesListCubit;
    },
    act: (MoviesListCubit cubit) => cubit.getMovies(),
    expect: () => [
      const MoviesListLoading(
        isFirstFetch: true,
        movies: [],
      ),
      const MoviesListError(
        isFirstFetch: false,
        message: 'Something went wrong',
        movies: [],
      )
    ],
  );
}
