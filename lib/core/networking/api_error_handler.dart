import 'package:dio/dio.dart';
import 'package:imsomitiapp/core/networking/api_constants.dart';
import 'package:imsomitiapp/core/networking/api_error_model.dart';

class ApiErrorHandler {
  late ApiErrorModel apiErrorModel;
  ApiErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleError(error);
    } else if (error is String) {
      apiErrorModel = _handleStringError(error);
    } else {
      apiErrorModel = DataSource.defaultError.getFailure();
    }
  }
  static ApiErrorModel _handleStringError(String error) {
    if(error == "unauthorized"){
       return ApiErrorModel(code: 401, message: error);
    }else{
       return ApiErrorModel(code: -1, message: error);
    }
   
  }
}

enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  conflict,
  internalServerError,
  connectionTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found
  static const int API_LOGIC_ERROR = 422; // API , lOGIC ERROR

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String NO_CONTENT =
      ApiErrors.noContent; // success with no data (no content)
  static const String BAD_REQUEST =
      ApiErrors.badRequestError; // failure, API rejected request
  static const String UNAUTORISED =
      ApiErrors.unauthorizedError; // failure, user is not authorised
  static const String FORBIDDEN =
      ApiErrors.forbiddenError; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      ApiErrors.internalServerError; // failure, crash in server side
  static const String NOT_FOUND =
      ApiErrors.notFoundError; // failure, crash in server side

  // local status code
  static String CONNECT_TIMEOUT = ApiErrors.timeoutError;
  static String CANCEL = ApiErrors.defaultError;
  static String RECIEVE_TIMEOUT = ApiErrors.timeoutError;
  static String SEND_TIMEOUT = ApiErrors.timeoutError;
  static String CACHE_ERROR = ApiErrors.cacheError;
  static String NO_INTERNET_CONNECTION = ApiErrors.noInternetError;
  static String DEFAULT = ApiErrors.defaultError;
}

ApiErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectionTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        final data = error.response?.data;
        if (error.response?.statusCode == 401) {
          return ApiErrorModel(
            code: 401,
            data: {"data": "Unauthorized"},
            message: "Token Expired"

          );
        } else {
          if (data is Map<String, dynamic>) {
            // JSON error
            return ApiErrorModel.fromJson(data);
          } else if (data is String) {
            // Non-JSON error (plain text / HTML)
            return ApiErrorModel(
              code: error.response!.statusCode ?? -1,
              message: data,
            );
          }
          return ApiErrorModel.fromJson(error.response!.data);
        }
      } else {
        return DataSource.defaultError.getFailure();
      }
    case DioExceptionType.unknown:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return ApiErrorModel.fromJson(error.response!.data);
      } else {
        return DataSource.defaultError.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.defaultError.getFailure();
  }
}

extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() {
    switch (this) {
      case DataSource.noContent:
        return ApiErrorModel(
          message: ResponseMessage.NO_CONTENT,
          code: ResponseCode.NO_CONTENT,
        );
      case DataSource.badRequest:
        return ApiErrorModel(
          message: ResponseMessage.BAD_REQUEST,
          code: ResponseCode.BAD_REQUEST,
        );
      case DataSource.forbidden:
        return ApiErrorModel(
          message: ResponseMessage.FORBIDDEN,
          code: ResponseCode.FORBIDDEN,
        );
      case DataSource.unauthorized:
        return ApiErrorModel(
          message: ResponseMessage.UNAUTORISED,
          code: 401,
        );
      case DataSource.notFound:
        return ApiErrorModel(
          message: ResponseMessage.NOT_FOUND,
          code: ResponseCode.NOT_FOUND,
        );
      case DataSource.conflict:
        return ApiErrorModel(
          message: ApiErrors.conflictError,
          code: ResponseCode.API_LOGIC_ERROR,
        );
      case DataSource.internalServerError:
        return ApiErrorModel(
          message: ResponseMessage.INTERNAL_SERVER_ERROR,
          code: ResponseCode.INTERNAL_SERVER_ERROR,
        );
      case DataSource.connectionTimeout:
        return ApiErrorModel(
          message: ResponseMessage.CONNECT_TIMEOUT,
          code: ResponseCode.CONNECT_TIMEOUT,
        );
      case DataSource.cancel:
        return ApiErrorModel(
          message: ResponseMessage.CANCEL,
          code: ResponseCode.CANCEL,
        );
      case DataSource.receiveTimeout:
        return ApiErrorModel(
          message: ResponseMessage.RECIEVE_TIMEOUT,
          code: ResponseCode.RECIEVE_TIMEOUT,
        );
      case DataSource.sendTimeout:
        return ApiErrorModel(
          message: ResponseMessage.SEND_TIMEOUT,
          code: ResponseCode.SEND_TIMEOUT,
        );
      case DataSource.cacheError:
        return ApiErrorModel(
          message: ResponseMessage.CACHE_ERROR,
          code: ResponseCode.CACHE_ERROR,
        );
      case DataSource.noInternetConnection:
        return ApiErrorModel(
          message: ResponseMessage.NO_INTERNET_CONNECTION,
          code: ResponseCode.NO_INTERNET_CONNECTION,
        );
      case DataSource.defaultError:
        return ApiErrorModel(
          code: ResponseCode.DEFAULT,
          message: ResponseMessage.DEFAULT,
        );
    }
  }
}
