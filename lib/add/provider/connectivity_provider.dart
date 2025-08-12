import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

final connectivityStatusProvider =
    StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(
  (ref) => ConnectivityStatusNotifier(),
);

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityStatusNotifier() : super(ConnectivityStatus.notDetermined) {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      updateConnectivityStatus(results);
    });

    Connectivity().checkConnectivity().then((List<ConnectivityResult> results) {
      updateConnectivityStatus(results);
    });
  }

  void updateConnectivityStatus(List<ConnectivityResult> results) {
    final hasConnection = results.any((result) => result != ConnectivityResult.none);
    
    final newStatus = hasConnection
        ? ConnectivityStatus.isConnected
        : ConnectivityStatus.isDisconnected;

    if (newStatus != state) {
      state = newStatus;
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
