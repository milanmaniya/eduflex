import 'dart:async';
import 'package:eduflex/screen/student/tech_news_screens/tech_news_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/techer_dashboard_screen.dart';
import 'package:eduflex/screen/welcome_screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashService {
  final localStorage = GetStorage();

  void navigate() {
    if (FirebaseAuth.instance.currentUser != null) {
      Timer(const Duration(seconds: 3), () {
        localStorage.read('Screen') == 'Teacher'
            ? Get.offAll(() => const TeacherDashBoardScreen())
            : Get.offAll(() => const TechNewsScreen());
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Get.offAll(() => const WelcomeScreen());
      });
    }
  }
}
