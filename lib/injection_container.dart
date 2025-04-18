import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hjvyas/api/api_client.dart';

import 'api/services/HJVyasApiService.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Register Dio instance
  getIt.registerSingleton<Dio>(apiClient);

  // Register services
  // getIt.registerSingleton<HJVyasApiService>(HJVyasApiService());
  // Register services
  getIt.registerSingleton<HJVyasApiService>(
    HJVyasApiService(getIt<Dio>()), // Injects Dio
  );
}
