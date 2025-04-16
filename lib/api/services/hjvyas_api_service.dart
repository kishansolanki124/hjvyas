import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hjvyas/api/api_client.dart';
import 'package:hjvyas/api/models/HomeMediaResponse.dart';

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


  Future<HomeMediaResponse> homeMediaApi() async {

    // First check basic connectivity
    if (!await ConnectivityService.isConnected) {
      throw NetworkException('No internet connection', isConnectionIssue: true);
    }

    try {
      // URL-encoded data as a Map
      final formData = {
        'start': "0",
        'end': '2'
      };

      final response = await _client.post('/get_slider',
        data: formData,
        options: Options(
          // Explicitly set content-type (Dio often infers this, but be explicit)
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),);
      print('response is $response');
      return HomeMediaResponse.fromJson(jsonDecode(response.data));
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
