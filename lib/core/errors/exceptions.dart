import 'package:dio/dio.dart';

import 'error_model.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  try {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.sendTimeout:
        throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.receiveTimeout:
        throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.badCertificate:
        throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.cancel:
        throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.connectionError:
        throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.unknown:
        throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400: // Bad request
            print(e.response!.data == null);
            print(e.response!.data);
            throw ServerException(
                errModel: ErrorModel.fromJson(e.response!.data));
          case 401: //unauthorized
            print(e.response!.data == null);
            print(e.response!.data);
            throw ServerException(
                errModel: ErrorModel.fromJson(e.response!.data));
          case 403: //forbidden
            throw ServerException(
                errModel: ErrorModel.fromJson(e.response!.data));
          case 404: //not found
            throw ServerException(
                errModel: ErrorModel.fromJson(e.response!.data));
          case 409: //cofficient
            throw ServerException(
                errModel: ErrorModel.fromJson(e.response!.data));
          case 422: //  Unprocessable Entity
            throw ServerException(
                errModel: ErrorModel.fromJson(e.response!.data));
          case 504: // Server exception
            throw ServerException(
                errModel: ErrorModel.fromJson(e.response!.data));
        }
    }
  } catch (error) {
    print("Error caught: ${error.toString()}");
    if (error is ServerException) {
      print("Error Message: ${error.errModel.errorMessage}");
    } else {
      print("Unknown error occurred");
    }

    // Rethrow the error to propagate it upwards
    rethrow;
  }
}
//