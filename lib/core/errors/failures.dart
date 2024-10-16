import 'package:dio/dio.dart';

abstract class Failure {
  final String errMassage;
  final int statusCode;

  const Failure(this.errMassage, this.statusCode);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMassage, super.statusCode);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          'Connection timeout with ApiServer',
          dioException.response?.statusCode ?? 600,
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          'Send timeout with ApiServer',
          dioException.response?.statusCode ?? 601,
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          'Receive timeout with ApiServer',
          dioException.response?.statusCode ?? 602,
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          'badCertificate with ApiServer',
          dioException.response?.statusCode ?? 603,
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response?.statusCode ?? 604,
          dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          'Request to  ApiServer was cancel',
          dioException.response?.statusCode ?? 605,
        );
      case DioExceptionType.connectionError:
        return ServerFailure('network error, check your internet !', 606);
      case DioExceptionType.unknown:
        return ServerFailure('Ops There was an Error, Please try again!', 607);
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    print('statusCode is $statusCode');

    var error;
    if (response is Map) {
      error = response[
          'message']; // ! here we should change the key after check from haydar baddour
    }
    print("error $error");
    if (statusCode == 401 || statusCode == 403 || statusCode == 422) {
      if (response is Map) {
        print(response['message']);
      }
      return ServerFailure(error ?? "auth error", statusCode);
    } else if (statusCode == 404) {
      return ServerFailure(error ?? "404 not found", statusCode);
    } else if (statusCode == 500) {
      return ServerFailure(
          'internal Server error, Please try later', statusCode);
    } else if (statusCode == 400) {
      return ServerFailure(error ?? "valid error", statusCode);
    } else {
      return ServerFailure(
          'Ops There was an Error, Please try again', statusCode);
    }
  }
}
