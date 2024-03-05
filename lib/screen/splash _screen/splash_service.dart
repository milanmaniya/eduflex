import 'dart:async';
import 'package:eduflex/screen/student/dashboard/student_dashboard_screen.dart';
import 'package:eduflex/screen/student/library_screens/google_library.dart';
import 'package:eduflex/screen/teacher/dashboard/techer_dashboard_screen.dart';
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
            : Get.offAll(() => const StudentDashBoardScreen());
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Get.offAll(() => const GoogleLibraryScreen());
      });
    }
  }
}
