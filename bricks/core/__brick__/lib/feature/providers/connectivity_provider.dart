import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../core/di/locator.dart';

@injectable
class ConnectionViewModel extends StateNotifier<bool> {
  final Connectivity _connectivity;

  // Constructor with dependency injection for Connectivity
  ConnectionViewModel(this._connectivity) : super(true) {
    _monitorConnection();
  }

  // Monitors the connectivity changes
  void _monitorConnection() {
    _connectivity.onConnectivityChanged.listen((event) {
      state = event.contains(ConnectivityResult.none) ? false : true;
    });
  }
}

// Riverpod provider for ConnectionViewModel
final connectionViewModelProvider =
    StateNotifierProvider<ConnectionViewModel, bool>((ref) {
  return getIt<
      ConnectionViewModel>(); // Retrieve ConnectionViewModel from get_it
});
