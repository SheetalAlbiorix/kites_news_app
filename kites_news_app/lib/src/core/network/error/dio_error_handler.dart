import 'package:dio/dio.dart';

const String kRequestCancelled = "Request to API server was cancelled";
const String kConnectionTimeout = "Connection timeout with API server";
const String kReceiveTimeout = "Receive timeout in connection with API server";
const String kInvalidInput = "Invalid input. Please check your details.";
const String kBadRequest = "Bad request. Please try again.";
const String kUnauthorized = "Unauthorized. Please log in.";
const String kAccessDenied = "Access denied.";
const String kResourceNotFound = "Resource not found";
const String kGenericError = "Something went wrong, Please try again later";
const String kSendTimeout = "Send timeout in connection with API server";
const String kNoInternet = "Please check your network.";

String handleDioError(DioException error) {
  String errorDescription = "";

  switch (error.type) {
    case DioExceptionType.cancel:
      errorDescription = kRequestCancelled;
      break;
    case DioExceptionType.connectionTimeout:
      errorDescription = kConnectionTimeout;
      break;
    case DioExceptionType.receiveTimeout:
      errorDescription = kReceiveTimeout;
      break;
    case DioExceptionType.badResponse:
      {
        final statusCode = error.response?.statusCode;
        if (statusCode == 200 || statusCode == 422) {
          errorDescription = kInvalidInput;
        } else if (statusCode == 413) {
          errorDescription = error.response?.statusMessage ?? kGenericError;
        } else if (statusCode == 400) {
          errorDescription = kBadRequest;
        } else if (statusCode == 401) {
          errorDescription = kUnauthorized;
        } else if (statusCode == 403) {
          errorDescription = kAccessDenied;
        } else if (statusCode == 404) {
          errorDescription = kResourceNotFound;
        } else {
          errorDescription = kGenericError;
        }
        break;
      }
    case DioExceptionType.sendTimeout:
      errorDescription = kSendTimeout;
      break;
    case DioExceptionType.badCertificate:
      // Handle separately if needed
      break;
    case DioExceptionType.connectionError:
      errorDescription = kNoInternet;
      break;
    case DioExceptionType.unknown:
      errorDescription = kGenericError;
      break;
  }

  return errorDescription;
}
