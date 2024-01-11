import 'dart:async';
import 'package:eduflex/common/widget/email_verify_screen/email_verify_screen.dart';
import 'package:eduflex/screen/home_screen/home_screen.dart';
import 'package:eduflex/screen/welcome_screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashService {
  void navigate() {
    if (FirebaseAuth.instance.currentUser != null) {
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Timer(const Duration(seconds: 3), () {
          Get.offAll(() => const HomeScreen());
        });
      } else {
        Timer(const Duration(seconds: 3), () {
          Get.offAll(() => const VerifyEmail());
        });
      }
    } else {
      Timer(const Duration(seconds: 3), () {
        Get.offAll(() => const WelcomeScreen());
      });
    }
  }
}
