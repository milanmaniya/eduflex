import 'dart:io';

import 'package:eduflex/common/widget/phone_number_verification_screen/otp_verification_screen.dart';
import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/screen/welcome_screen/welcome_screen.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class AuthenticationReposotiry extends GetxController {
  static AuthenticationReposotiry get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {}

// login
  Future<UserCredential> loginWithEmailIdAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return user;
    } catch (e) {
      throw 'Sometimes went wrong. Please try again';
    }
  }

// register
  Future<UserCredential> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } catch (e) {
      TLoader.errorSnackBar(
          title: '',
          message:
              'This Email Address is already used, please try another email address');
      throw 'Sometimes went wrong. Please try again';
    }
  }

  // sign in with google
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await userAccount!.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return FirebaseAuth.instance.signInWithCredential(credentials);
    } catch (e) {
      throw TLoader.warningSnackBar(
          title: 'Email Send Verification', message: e.toString());
    }
  }

  // mail verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } catch (e) {
      TLoader.warningSnackBar(
          title: 'Email Send Verification', message: e.toString());
    }
  }

  //phone number verification
  void sendOtp(
      {required String phoneNumber, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      codeAutoRetrievalTimeout: (verificationId) {},
      codeSent: (verificationId, forceResendingToken) {
        Get.to(
          () => OtpVerificationScreen(
            verificationId: verificationId,
            phoneNumber: phoneNumber,
          ),
        );
      },
      verificationFailed: (error) {
        TLoader.errorSnackBar(title: 'Oh Snap!', message: error.toString());
      },
      verificationCompleted: (phoneAuthCredential) {
        TLoader.successSnackBar(
          title: 'Otp send successfully!',
          message: 'Verification complete successfully',
        );
      },
      timeout: const Duration(seconds: 30),
    );
  }

  //logout
  Future<void> logout() async {
    try {
      APIS.updateActiveStatus(false);

      await GoogleSignIn().signOut().then((value) {
        FirebaseAuth.instance.signOut().then((value) {
          Get.offAll(() => const WelcomeScreen());
          TLoader.successSnackBar(
              title: 'User Logout', message: 'User Logout Successfully');
        });
      });
    } catch (e) {
      TLoader.warningSnackBar(title: 'Oh Snap! ', message: e.toString());
    }
  }

  // forgot password

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      TLoader.warningSnackBar(
          title: 'Email Send Verification', message: e.toString());
    }
  }

  void workBookFunction({
    required List<String> header,
    required Set studentRollNoList,
    required Set studentName,
    required List<bool> indexColor,
  }) async {
    final finalIndex = indexColor.sublist(0, studentRollNoList.length);

    final Workbook workbook = Workbook();

    final Worksheet worksheet = workbook.worksheets[0];

    for (var i = 0; i < header.length; i++) {
      worksheet.getRangeByIndex(1, i + 1).setText(header[i]);

      for (int i = 0; i < studentRollNoList.length; i++) {
        worksheet
            .getRangeByIndex(i + 2, 1)
            .setNumber(studentRollNoList.elementAt(i));
        worksheet
            .getRangeByIndex(i + 2, 2)
            .setText(studentName.elementAt(i).toString());
        worksheet
            .getRangeByIndex(i + 2, 3)
            .setValue(finalIndex.elementAt(i));
      }

      worksheet.autoFitColumn(i + 1);
      worksheet.autoFitRow(1);
    }
    worksheet.autoFilters;

    final byte = workbook.saveAsStream();

    final path = (await getApplicationSupportDirectory()).path;

    final fileName = '$path/Attendance.xlsx';

    final File file = File(fileName);

    await file.writeAsBytes(byte, flush: true);

    workbook.dispose();

    OpenFilex.open(fileName);

    // final List<int> bytes = workbook.saveAsStream();

    // final String path = (await getApplicationSupportDirectory()).path;

    // final String fileName = '$path/Attendance.xlsx';

    // final File file = File(fileName);

    // await file.writeAsBytes(bytes, flush: true);

    // workbook.dispose();

    // OpenFilex.open(fileName);
  }
}
