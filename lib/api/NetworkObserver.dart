import 'package:connectivity_plus/connectivity_plus.dart';

import 'NetworkUtils.dart';

class NetworkObserver {
  final Connectivity _connectivity = Connectivity();

  Stream<bool> get connectivityStream => _connectivity.onConnectivityChanged
      .asyncMap((result) async => result != ConnectivityResult.none
      && await NetworkUtils.hasInternetAccess());

  void dispose() {
    // Clean up if needed
  }
}