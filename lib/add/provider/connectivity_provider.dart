import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
  (ref) => ConnectivityStatusNotifier(),
);

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatusNotifier() : super(ConnectivityStatus.notDetermined) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      updateConnectivityStatus(result);
    });

    Connectivity().checkConnectivity().then(updateConnectivityStatus);
  }

  void updateConnectivityStatus(ConnectivityResult result) {
    final newStatus = result != ConnectivityResult.none
        ? ConnectivityStatus.isConnected
        : ConnectivityStatus.isDisconnected;

    if (newStatus != state) {
      state = newStatus;
    }
  }
}
