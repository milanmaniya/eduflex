import 'dart:async';

import 'package:eduflex/screen/welcome_screen/welcome_screen.dart';
import 'package:get/get.dart';

class SplashService {
  void navigate() {
    Timer(const Duration(seconds: 5), () {
      Get.to(() => const WelcomeScreen());
    });
  }
}
