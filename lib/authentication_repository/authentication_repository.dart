import 'package:eduflex/home/home_page.dart';
import 'package:eduflex/screen/teacher/login_screen/teacher_login_screen.dart';
import 'package:eduflex/screen/teacher/widget/teacher_verify_email.dart';
import 'package:eduflex/screen/welcome_screen/welcome_screen.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationReposotiry extends GetxController {
  static AuthenticationReposotiry get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    // screenRedirect();
  }

  screenRedirect() {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const HomePage());
      } else {
        Get.offAll(() => TeacherVerifyEmailScreen(
              email: user.email,
            ));
      }
    } else {
      Get.offAll(() => const WelcomeScreen());
    }
  }

// register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return TLoader.errorSnackBar(
          title: 'Something Went Wrong. Please try again',
          message: e.toString());
    }
  }

  // mail verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } catch (e) {
      TLoader.warningSnackBar(
          title: 'Email Send Verification', message: e.toString());
    }
  }

  //logout
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const TeacherLoginScreen());
    } catch (e) {
      TLoader.warningSnackBar(title: '', message: e.toString());
    }
  }
}
