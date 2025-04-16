import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final Connectivity _connectivity = Connectivity();

  /// Returns true if connected to mobile data or WiFi
  static Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  /// Stream of connectivity changes
  static Stream<bool> get connectionStream =>
      _connectivity.onConnectivityChanged.map((result) => result != ConnectivityResult.none);
}