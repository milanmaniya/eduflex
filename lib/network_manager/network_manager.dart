import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatues = ConnectivityResult.none.obs;

  // initialize network manager
  @override
  void onInit() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult event) async {
    _connectionStatues.value = event;

    if (_connectionStatues.value == ConnectivityResult.none) {
      TLoader.warningSnackBar(title: 'No Internet Connection');
    }
  }

  //check internet connection
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();

      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  //dispose or close the active connectivity stream

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
