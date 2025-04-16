import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hjvyas/api/api_client.dart';

import '../ConnectivityService.dart';
import '../exceptions/exceptions.dart';
import '../models/LogoResponse.dart';

class HJVyasApiService {
  final Dio _client = apiClient;

  HJVyasApiService(Dio dio);

  Future<LogoResponse> logo() async {

    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      final response = await _client.post('/get_logo');
      print('response is $response');
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
