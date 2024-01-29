import 'dart:async';
import 'package:eduflex/common/widget/phone_number_verification_screen/phone_number_screen.dart';
import 'package:eduflex/screen/student/dashboard/student_dashboard_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/techer_dashboard_screen.dart';
import 'package:eduflex/screen/welcome_screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashService {
  final localStorage = GetStorage();

  void navigate() {
    if (FirebaseAuth.instance.currentUser != null) {
      localStorage.read('phoneVerify') == false
          ? Get.offAll(() => const PhoneNumberScreen())
          : Timer(const Duration(seconds: 3), () {
              localStorage.read('Screen') == 'Teacher'
                  ? Get.offAll(() => const TeacherDashBoardScreen())
                  : Get.offAll(() => const StudentDashBoardScreen());
            });
    } else {
      Timer(const Duration(seconds: 3), () {
        Get.offAll(() => const WelcomeScreen());
      });
    }
  }
}
