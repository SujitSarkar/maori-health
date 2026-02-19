import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:maori_health/core/config/app_constants.dart';

class NetworkChecker {
  final Connectivity _connectivity;
  final StreamController<bool> _connectionController = StreamController<bool>.broadcast();
  bool _isConnected = false;

  NetworkChecker({Connectivity? connectivity}) : _connectivity = connectivity ?? Connectivity();

  void initialize() {
    _connectivity.onConnectivityChanged.listen((_) => checkConnection());
    checkConnection();
  }

  Stream<bool> get connectionStream => _connectionController.stream;

  Future<bool> get hasConnection async => checkConnection();

  Future<bool> checkConnection() async {
    final previousState = _isConnected;
    HttpClient? client;

    try {
      client = HttpClient()..connectionTimeout = AppConstants.connectivityProbeTimeout;

      final uri = Uri.parse(AppConstants.connectivityProbeUrl);
      final request = await client.getUrl(uri).timeout(AppConstants.connectivityProbeTimeout);
      request.followRedirects = false;

      final response = await request.close().timeout(AppConstants.connectivityProbeTimeout);

      _isConnected = response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.noContent;
    } on SocketException catch (_) {
      _isConnected = false;
    } on TimeoutException catch (_) {
      _isConnected = false;
    } catch (_) {
      _isConnected = false;
    } finally {
      client?.close(force: true);
    }

    if (previousState != _isConnected) {
      _connectionController.add(_isConnected);
    }

    return _isConnected;
  }

  void dispose() {
    _connectionController.close();
  }
}
