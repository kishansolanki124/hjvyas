import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hjvyas/api/api_client.dart';

import 'api/services/user_service.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Register Dio instance
  getIt.registerSingleton<Dio>(apiClient);

  // Register services
  // getIt.registerSingleton<UserService>(UserService());
  // Register services
  getIt.registerSingleton<UserService>(
    UserService(getIt<Dio>()), // Injects Dio
  );
}
