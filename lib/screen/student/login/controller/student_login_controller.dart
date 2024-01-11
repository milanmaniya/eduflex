import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/screen/splash%20_screen/splash_service.dart';
import 'package:eduflex/screen/student/model/student_model.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentLoginController extends GetxController {
  static StudentLoginController get instance => Get.find();

  
  RxBool isObsecure = true.obs;

  RxBool isChecked = false.obs;

  final localStorage = GetStorage();

  final key = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();


  void iaGoogleAuthentication() async {
    final userCredential =
        await AuthenticationReposotiry.instance.signInWithGoogle();

    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final newStudent = Student(
      div: '',
      firstName: '',
      lastName: '',
      userName: userCredential.user!.displayName ?? '',
      email: userCredential.user!.email ?? '',
      phoneNumber: userCredential.user!.phoneNumber ?? '',
      password: txtPassword.text.trim(),
      fieldValue: '',
      yearValue: '',
      isOnline: false,
      createAt: time,
      image: userCredential.user!.photoURL ?? '',
      pushToken: '',
      id: userCredential.user!.uid,
      about: '',
    );

    FirebaseFirestore.instance
        .collection(localStorage.read('Screen'))
        .doc(userCredential.user!.uid)
        .set(newStudent.toJson())
        .then((value) {
      SplashService().navigate();

      TLoader.successSnackBar(
        title: 'Congratulation',
        message: 'Your account has been  created! Verify email to continue',
      );
    }).onError(
      (error, stackTrace) =>
          TLoader.errorSnackBar(title: 'Oh Snap! ', message: error),
    );
  }


}
