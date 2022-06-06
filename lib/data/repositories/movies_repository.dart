import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_tv_shows/data/models/error_response.dart';
import 'package:flutter_tv_shows/data/models/shows_list_response.dart';
import 'package:flutter_tv_shows/data/network/dio_exceptions.dart';
import 'package:flutter_tv_shows/utils/urls.dart';

abstract class MoviesRepository {
  Future<ShowsListResponse> getMovieList(int page);
}

class MoviesRepositoryImpl implements MoviesRepository {
  final Dio dio;

  MoviesRepositoryImpl({required this.dio});
  @override
  Future<ShowsListResponse> getMovieList(int page) async {
    try {
      final res = await dio.get(showsUrl);
      if (res.statusCode != 200) {
        final error =
            ErrorResponse.fromJson(json.decode(json.encode(res.data)));
        throw Exception(error.errors?.join("\n"));
      }
      return ShowsListResponse.fromJson(json.decode(json.encode(res.data)));
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
