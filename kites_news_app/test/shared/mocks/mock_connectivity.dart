import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const List<ConnectivityResult> kCheckConnectivityResult = [ConnectivityResult.wifi];

class MockConnectivityPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements ConnectivityPlatform {
  late Stream<List<ConnectivityResult>> _onConnectivityChanged;

  @override
  Future<List<ConnectivityResult>> checkConnectivity() async {
    return kCheckConnectivityResult;
  }

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    _onConnectivityChanged =
        Future.wait([
          Future.value(ConnectivityResult.wifi),
          Future.value(ConnectivityResult.none),
          Future.value(ConnectivityResult.mobile),
        ]).then((results) async {
          await Future.delayed(const Duration(seconds: 1));
          return results; // Return the list after delay
        }).asStream();

    return _onConnectivityChanged;
  }
}
