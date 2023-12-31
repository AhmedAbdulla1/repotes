import 'package:dio/dio.dart';
import 'package:reports/presentation/resources/string_manager.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioExceptionType) {
      // print(error.type);
      // print(error.response?.data);
      // print(error.response?.statusCode);
      // print(error.response?.statusMessage);
      failure = _handlerError(error);
    } else {
      failure = DataSource.customDefault.getFailure();
    }
  }
}

Failure _handlerError(DioExceptionType error) {
  switch (error) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();

    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.badResponse:
        return Failure(
          code: 1,
          message: "",
        );
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    default:
      return DataSource.customDefault.getFailure();
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  customDefault
}

extension DataSuorceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case DataSource.noContent:
        return Failure(
          code: ResponseCode.noContent,
          message: ResponseMessage.noContent,
        );
      case DataSource.badRequest:
        return Failure(
          code: ResponseCode.badRequest,
          message: ResponseMessage.badRequest,
        );
      case DataSource.forbidden:
        return Failure(
          code: ResponseCode.forbidden,
          message: ResponseMessage.forbidden,
        );
      case DataSource.unAuthorised:
        return Failure(
          code: ResponseCode.unAuthorised,
          message: ResponseMessage.unAuthorised,
        );
      case DataSource.notFound:
        return Failure(
          code: ResponseCode.notFound,
          message: ResponseMessage.notFound,
        );
      case DataSource.internalServerError:
        return Failure(
          code: ResponseCode.internalServerError,
          message: ResponseMessage.internalServerError,
        );
      case DataSource.connectTimeout:
        return Failure(
          code: ResponseCode.connectTimeout,
          message: ResponseMessage.connectTimeout,
        );
      case DataSource.cancel:
        return Failure(
          code: ResponseCode.cancel,
          message: ResponseMessage.cancel,
        );
      case DataSource.receiveTimeout:
        return Failure(
          code: ResponseCode.receiveTimeout,
          message: ResponseMessage.receiveTimeout,
        );
      case DataSource.sendTimeout:
        return Failure(
          code: ResponseCode.sendTimeout,
          message: ResponseMessage.sendTimeout,
        );
      case DataSource.cacheError:
        return Failure(
          code: ResponseCode.cacheError,
          message: ResponseMessage.cacheError,
        );
      case DataSource.noInternetConnection:
        return Failure(
          code: ResponseCode.noInternetConnection,
          message: ResponseMessage.noInternetConnection,
        );
      case DataSource.customDefault:
        return Failure(
          code: ResponseCode.customDefault,
          message: ResponseMessage.customDefault,
        );
    }
  }
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unAuthorised = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int notFound = 404; // failure , not found
  static const int internalServerError = 500; // failure, crash in server side

  // local status code
  static const int connectTimeout = -1; //
  static const int cancel = -2; //
  static const int receiveTimeout = -3; //
  static const int sendTimeout = -4; //
  static const int cacheError = -5; //
  static const int noInternetConnection = -6; //
  static const int customDefault = -7;
}

class ResponseMessage {
  static String success = AppStrings.success; // success with data
  static String noContent =
      AppStrings.success; // success with no data (no content)
  static String badRequest =
      AppStrings.badRequestError; // failure, API rejected request
  static String unAuthorised =
      AppStrings.unauthorizedError; // failure, user is not authorised
  static String forbidden =
      AppStrings.forbiddenError; //  failure, API rejected request
  static String notFound = AppStrings.notFoundError; //  failure, not found
  static String internalServerError =
      AppStrings.internalServerError; // failure, crash in server side
  static String connectTimeout = AppStrings.timeoutError;
  static String cancel = AppStrings.defaultError;
  static String receiveTimeout = AppStrings.timeoutError;
  static String sendTimeout = AppStrings.timeoutError;
  static String cacheError = AppStrings.cacheError;
  static String noInternetConnection = AppStrings.noInternetError;
  static String customDefault = AppStrings.defaultError;
}

class ApiInternalStatus {
  static const int success = 1;
  static const int failure = 0;
}
