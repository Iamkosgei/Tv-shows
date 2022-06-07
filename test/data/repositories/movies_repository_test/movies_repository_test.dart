import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tv_shows/data/models/shows_list_response.dart';
import 'package:flutter_tv_shows/data/repositories/movies_repository.dart';
import 'package:flutter_tv_shows/utils/urls.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../auth_repository_test/auth_repository_test_data.dart';
import 'movie_repository_test_data.dart';
import 'movies_repository_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio dio;

  late MoviesRepositoryImpl moviesRepositoryImpl;

  setUp(() {
    dio = MockDio();
    moviesRepositoryImpl = MoviesRepositoryImpl(
      dio: dio,
    );
  });

  test('getMovieList() returns a list of movies when successful', () async {
    when(dio.get(
      showsUrl,
      queryParameters: {
        'page': 1,
      },
    )).thenAnswer(
      (_) async => Future.value(
        Response(
          statusCode: 200,
          data: successGetMoviesData,
          requestOptions: RequestOptions(path: showsUrl),
        ),
      ),
    );

    final response = await moviesRepositoryImpl.getMovieList(1);

    expect(response, isA<ShowsListResponse>());

    verify(dio.get(
      showsUrl,
      queryParameters: {
        'page': 1,
      },
    )).called(1);
  });

  test('getMovieList()  throws an DioError when not successful', () async {
    when(dio.get(
      showsUrl,
      queryParameters: {
        'page': 1,
      },
    )).thenThrow(
      DioError(
        type: DioErrorType.response,
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: showsUrl),
        ),
        error: errorUserLoginResponse,
        requestOptions: RequestOptions(path: showsUrl),
      ),
    );

    expect(() => moviesRepositoryImpl.getMovieList(1), throwsA('Unauthorized'));

    verify(dio.get(
      showsUrl,
      queryParameters: {
        'page': 1,
      },
    )).called(1);
  });

  test('getMovieList() throws an Exception when not successful', () async {
    when(dio.get(
      showsUrl,
      queryParameters: {
        'page': 1,
      },
    )).thenThrow(Exception('Something went wrong'));

    expect(() => moviesRepositoryImpl.getMovieList(1), throwsException);

    verify(dio.get(
      showsUrl,
      queryParameters: {
        'page': 1,
      },
    )).called(1);
  });
}
