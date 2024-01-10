import 'dart:async';

import 'package:eduflex/screen/home_screen/home_screen.dart';
import 'package:eduflex/screen/welcome_screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashService {
  void navigate() {
    if (FirebaseAuth.instance.currentUser != null) {
      Timer(const Duration(seconds: 3), () {
        Get.offAll(() => const HomeScreen());
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Get.offAll(() => const WelcomeScreen());
      });
    }
  }
}
