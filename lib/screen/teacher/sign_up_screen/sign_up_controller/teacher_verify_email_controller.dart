import 'dart:async';
import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/common/widget/success_screen/success_screen.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TeacherVerifyEmailController extends GetxController {
  static TeacherVerifyEmailController get instance => Get.find();

  // send email whenever verify screen appears & set timer for auto redirect.

  @override
  void onInit() {
    sendEmailVerification();
    sendTimerForAutoRedirect();
    super.onInit();
  }

  // send email verification link

  sendEmailVerification() {
    try {
      AuthenticationReposotiry.instance.sendEmailVerification();
      TLoader.successSnackBar(
          title: 'Email Send',
          message: 'Please Check Your inbox and verify your email.');
    } catch (e) {
      TLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // timer to automatically redirect on email verification

  sendTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user?.emailVerified ?? false) {
        timer.cancel();

        Get.off(
          () => SucessScreen(
            title: TTexts.yourAccountCreatedTitle,
            subTitle: TTexts.yourAccountCreatedSubTitle,
            imageString: 'assets/animation/Success.gif',
            pressed: AuthenticationReposotiry.instance.screenRedirect(),
          ),
        );
      }
    });
  }

  // manually check if email verified

  checkEmailVerificationStutues() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SucessScreen(
          title: TTexts.yourAccountCreatedTitle,
          subTitle: TTexts.yourAccountCreatedSubTitle,
          imageString: 'assets/animation/Success.gif',
          pressed:
              AuthenticationReposotiry.instance.screenRedirect(),
        ),
      );
    }
  }
}
