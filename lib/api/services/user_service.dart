import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hjvyas/api/api_client.dart';

import '../ConnectivityService.dart';
import '../exceptions/exceptions.dart';
import '../models/LogoResponse.dart';

class UserService {
  //final Dio _client = apiClient;
  final Dio _client = apiClient;

  UserService(Dio dio);

  // UserService(Dio dio) {
  //   _client = dio;
  // }

  Future<LogoResponse> logo() async {

    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      //throw NetworkException('No internet connection', isConnectionIssue: true);
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    // if (!await NetworkUtils.hasInternetAccess()) {
    //   throw NetworkException('No internet connection');
    // }

    try {
      //final response = await _client.get('/users/$userId');
      final response = await _client.post('/get_logo');
      print('response is $response');
      //return LogoResponse.fromJson(response.data);
      return LogoResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      print('DioException is message ${e.message} and erorr is ${e.error}');
      if (e.response != null) {
        print('DioException is response ${e.response}');
        print('e.response!.statusCode ${e.response!.statusCode!}');
        throw ApiResponseException(e.message!, e.response!.statusCode!);
      } else {
        print('No internet connection');
        throw NetworkException('No internet connection');
      }
    }
  }
}
