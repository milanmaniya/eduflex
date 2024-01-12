import 'dart:async';
import 'package:eduflex/common/widget/email_verify_screen/email_verify_screen.dart';
import 'package:eduflex/screen/home_screen/home_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/techer_dashboard_screen.dart';
import 'package:eduflex/screen/welcome_screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashService {
  final localStorage = GetStorage();

  void navigate() {
    if (FirebaseAuth.instance.currentUser != null) {
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Timer(const Duration(seconds: 3), () {
          localStorage.read('Screen') == 'Teacher'
              ? Get.offAll(() => const TeacherDashBoardScreen())
              : const HomeScreen();
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
