import 'package:dio/dio.dart';

import 'config/api_config.dart';
import 'interceptors/logging_interceptor.dart';

final Dio apiClient = Dio(
  BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: Duration(milliseconds: ApiConfig.connectTimeout),
    receiveTimeout: Duration(milliseconds: ApiConfig.receiveTimeout),
    responseType: ResponseType.json,
  ),
)..interceptors.add(LoggingInterceptor()); // Add interceptors as needed
