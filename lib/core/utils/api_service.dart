import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sahab_project/core/const.dart';
import 'package:sahab_project/core/utils/cache/cache_helper.dart';

class ApiService {
  // final _baseUrl = fakeUrl;
  final Dio dio;

  ApiService(this.dio);

  Future<dynamic> get(
      {required String endPoint, CancelToken? cancelToken}) async {
    String? token = await CacheHelper.getData(key: Constant.kToken);
    print(token);
    dio.options.headers["Authorization"] = "Bearer $token";
    // dio.options.headers[]
    var response = await dio.get(endPoint, cancelToken: cancelToken);
    print(endPoint);
    print('-----------------------------------------------------------');
    // print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> getWithBody({
    required String endPoint,
    CancelToken? cancelToken,
    required var data,
  }) async {
    // String token = await CasheHelper.getData(key: Constants.kToken);
    // print(token);
    // dio.options.headers["Authorization"] = "Bearer $token";
    // dio.options.headers[]
    var response = await dio.get(endPoint, data: data);
    print('-----------------------------------------------------------');
    // print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required var data,
    bool isLogin = false,
    CancelToken? cancelToken,
  }) async {
    print(endPoint);
    if (!isLogin) {
      String? token = await CacheHelper.getData(key: Constant.kToken);
      dio.options.headers["Authorization"] = "Bearer $token";
    }
    var response =
        await dio.post(endPoint, data: data, cancelToken: cancelToken);
    debugPrint('55555555555555555555555555555555555');
    debugPrint(
        '  heeeeeeeeeer resopopsdklfskdlvdl ${response.data} ----------------------------------------\n ---------------------------------------');
    return response.data;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    required var data,
    CancelToken? cancelToken,
  }) async {
    String? token = await CacheHelper.getData(key: Constant.kToken);

    dio.options.headers["Authorization"] = "Bearer $token";
    // print('heeeere');
    var response =
        await dio.put(endPoint, data: data, cancelToken: cancelToken);
    // print('55555555555555555555555555555555555');
    // print(
    // '  heeeeeeeeeer resopopsdklfskdlvdl ${response.data} ----------------------------------------\n ---------------------------------------');
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    required int id,
    CancelToken? cancelToken,
  }) async {
    String? token = await CacheHelper.getData(key: Constant.kToken);
    dio.options.headers["Authorization"] = "Bearer $token";
    // headers: {
    //       'Content-Type': 'application/json',
    //     },
    dio.options.headers['Content-Type'] = "application/json";
    var response = await dio.delete('$endPoint$id', cancelToken: cancelToken);
    return response.data;
  }

  Future<Map<String, dynamic>> deleteMany(
      {required String endPoint, required var data}) async {
    // String token = await CasheHelper.getData(key: Constants.kToken);
    // dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers['Content-Type'] = "application/json";

    var response = await dio.delete(endPoint, data: data);
    return response.data;
  }
}
