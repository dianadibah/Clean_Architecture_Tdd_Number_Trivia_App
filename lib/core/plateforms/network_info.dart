import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final FlutterNetworkConnectivity flutterNetworkConnectivity;

  NetworkInfoImpl(this.flutterNetworkConnectivity);

  @override
  Future<bool> get isConnected =>
      flutterNetworkConnectivity.isInternetConnectionAvailable();
}
