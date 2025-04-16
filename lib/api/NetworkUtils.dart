import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class NetworkUtils {
  static Future<bool> hasInternetAccess() async {
    // Check if device has network connection
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Verify real internet access by pinging a reliable server
    try {
      final dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 3);
      await dio.get('https://www.google.com');
      return true;
    } catch (e) {
      return false;
    }
  }
}