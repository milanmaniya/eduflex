import 'package:eduflex/common/widget/forgot_password/reset_password.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassordController extends GetxController {
  static ForgotPassordController get instance => Get.find();

  TextEditingController txtEmail = TextEditingController();

  final key = GlobalKey<FormState>();

  // send reset password email
  sendPasswordResetEmail() async {
    try {
     await FirebaseAuth.instance
          .sendPasswordResetEmail(email: txtEmail.text.trim())
          .then((value) {
        TLoader.successSnackBar(
            title: 'Email Sent',
            message: 'Email Link Sent to Reset your Password'.tr);

        Get.to(() => ResetPassword(email: txtEmail.text.trim()));
      });

      
    } catch (e) {
      TLoader.warningSnackBar(
          title: 'Email Send Verification', message: e.toString());
    }
  }

  // resend the email for forgot password
  resendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: txtEmail.text.trim())
          .then((value) {
        TLoader.successSnackBar(
            title: 'Email Sent',
            message: 'Email Link Sent to Reset your Password'.tr);
      });
    } catch (e) {
      TLoader.warningSnackBar(
          title: 'Email Send Verification', message: e.toString());
    }
  }
}
