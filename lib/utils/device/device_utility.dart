import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TDeviceUtility {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
      ),
    );
  }

  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsect = View.of(context).viewInsets;
    return viewInsect.bottom == 0;
  }

  static bool isPortraitOrientation(BuildContext context) {
    final viewInsect = View.of(context).viewInsets;
    return viewInsect.bottom != 0;
  }

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  static double getDevicePixelRatio() {
    return MediaQuery.of(Get.context!).devicePixelRatio;
  }

  static double getStatusBarHeight() {
    return MediaQuery.of(Get.context!).padding.top;
  }

  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getKeyboardHeight(BuildContext context) {
    final viewInsect = View.of(Get.context!).viewInsets;
    return viewInsect.bottom;
  }

  static Future<bool> isKeyboardVisible() async {
    final viewInsect = View.of(Get.context!).viewInsets;
    return viewInsect.bottom > 0;
  }

  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(
      duration,
      () => HapticFeedback.vibrate(),
    );
  }

  static Future<void> setPreferedOrientation(
      List<DeviceOrientation> orientation) async {
    await SystemChrome.setPreferredOrientations(orientation);
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('Example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static bool isIso() {
    return Platform.isIOS;
  }

  static bool isAndrois() {
    return Platform.isAndroid;
  }
}
