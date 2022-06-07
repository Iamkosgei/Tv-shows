import 'package:dio/dio.dart';
import 'package:flutter_tv_shows/utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message =
            '${AppLocalizations.of(getGlobalApplicationContext()!)?.somethingWentWrong}';
        break;
      case DioErrorType.connectTimeout:
        message =
            '${AppLocalizations.of(getGlobalApplicationContext()!)?.connectionTimeout}';
        break;
      case DioErrorType.other:
        message =
            '${AppLocalizations.of(getGlobalApplicationContext()!)?.internetConnectionError}';
        break;
      case DioErrorType.receiveTimeout:
        message =
            '${AppLocalizations.of(getGlobalApplicationContext()!)?.receiveTimeOut}';
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
        message =
            '${AppLocalizations.of(getGlobalApplicationContext()!)?.sendTimeOut}';
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
        return '${AppLocalizations.of(getGlobalApplicationContext()!)?.badRequest}';
      case 401:
        return isAuthUrl
            ? '${AppLocalizations.of(getGlobalApplicationContext()!)?.invalidCredentials}'
            : '${AppLocalizations.of(getGlobalApplicationContext()!)?.unauthorized}';
      case 404:
        if (error is String) {
          return error.isNotEmpty
              ? error
              : '${AppLocalizations.of(getGlobalApplicationContext()!)?.somethingWentWrong}';
        } else {
          return error['message'] as String;
        }
      case 403:
        return '${AppLocalizations.of(getGlobalApplicationContext()!)?.sessionExpired}';
      case 500:
        if (error is String) {
          return error.isNotEmpty
              ? error
              : '${AppLocalizations.of(getGlobalApplicationContext()!)?.internalServerError}';
        } else {
          return error['message'] as String;
        }
      default:
        return '${AppLocalizations.of(getGlobalApplicationContext()!)?.somethingWentWrong}';
    }
  }

  @override
  String toString() => message;
}
