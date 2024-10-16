import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sahab_project/core/errors/failures.dart';
import 'package:sahab_project/core/utils/api_service.dart';
import 'package:sahab_project/core/utils/service_locator.dart';

class NotificationRepo {
  Future<Either<Failure, String>> sendToken(Map<String, dynamic> data) async {
    try {
      var response = await getIt
          .get<ApiService>()
          .post(endPoint: "/users/tokens", data: data);
      return right("send Notification token");
    } catch (e) {
      if (e is DioException) {
        print(' ########### Dio Exception #################');
        print(e);
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString(), 500));
    }
  }
}
