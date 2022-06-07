import 'package:dio/dio.dart';
import 'package:flutter_tv_shows/utils/utils.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = '${getGlobalApplocalization()?.somethingWentWrong}';
        break;
      case DioErrorType.connectTimeout:
        message = '${getGlobalApplocalization()?.connectionTimeout}';
        break;
      case DioErrorType.other:
        message = '${getGlobalApplocalization()?.internetConnectionError}';
        break;
      case DioErrorType.receiveTimeout:
        message = '${getGlobalApplocalization()?.receiveTimeOut}';
        break;

      case DioErrorType.response:
        message = _handleError(
              dioError.response?.statusCode,
              dioError.response?.data,
              isAuthUrl: dioError.requestOptions.path.contains('sign_in'),
            ) ??
            '';
        break;
      case DioErrorType.sendTimeout:
        message = '${getGlobalApplocalization()?.sendTimeOut}';
        break;
    }
  }

  late String message;

  String? _handleError(
    int? statusCode,
    dynamic error, {
    bool isAuthUrl = false,
  }) {
    switch (statusCode) {
      case 400:
        return '${getGlobalApplocalization()?.badRequest}';
      case 401:
        return isAuthUrl
            ? '${getGlobalApplocalization()?.invalidCredentials}'
            : '${getGlobalApplocalization()?.unauthorized}';
      case 404:
        if (error is String) {
          return error.isNotEmpty
              ? error
              : '${getGlobalApplocalization()?.somethingWentWrong}';
        } else {
          return error['message'] as String;
        }
      case 403:
        return '${getGlobalApplocalization()?.sessionExpired}';
      case 500:
        if (error is String) {
          return error.isNotEmpty
              ? error
              : '${getGlobalApplocalization()?.internalServerError}';
        } else {
          return error['message'] as String;
        }
      default:
        return '${getGlobalApplocalization()?.somethingWentWrong}';
    }
  }

  @override
  String toString() => message;
}
