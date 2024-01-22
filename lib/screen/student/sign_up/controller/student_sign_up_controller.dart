import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/screen/splash%20_screen/splash_service.dart';
import 'package:eduflex/screen/student/model/student_model.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentSignUpController extends GetxController {
  static StudentSignUpController get instance => Get.find();

  RxBool isObsecure = true.obs;

  RxBool isChecked = false.obs;

  final key = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLatName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtAbout = TextEditingController();

  RxString fieldValue = ''.obs;
  RxString yearValue = ''.obs;
  RxString divValue = ''.obs;

  final bcaYear = [
    'FY-BCA SEM-1',
    'FY-BCA SEM-2',
    'SY-BCA SEM-3',
    'SY-BCA SEM-4',
    'TY-BCA SEM-5',
    'TY-BCA SEM-6',
  ];
  final bbaYear = [
    'FY-BBA SEM-1',
    'FY-BBA SEM-2',
    'SY-BBA SEM-3',
    'SY-BBA SEM-4',
    'TY-BBA SEM-5',
    'TY-BBA SEM-6',
  ];

  final div = [
    'DIV-1',
    'DIV-2',
    'DIV-3',
    'DIV-4',
  ];

  void iaAuthentication() async {
    final userCredential =
        await AuthenticationReposotiry().registerWithEmailAndPassword(
      email: txtEmail.text.trim(),
      password: txtPassword.text.trim(),
    );

    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final newStudent = Student(
      firstName: txtFirstName.text.trim(),
      lastName: txtLatName.text.trim(),
      userName: txtUserName.text.trim(),
      email: txtEmail.text.trim(),
      phoneNumber: txtPhoneNumber.text.trim(),
      password: txtPassword.text.trim(),
      fieldValue: fieldValue.value,
      yearValue: yearValue.value,
      isOnline: false,
      createAt: time,
      image: '',
      pushToken: '',
      id: userCredential.user!.uid,
      about: txtAbout.text.trim(),
      div: divValue.value,
      lastActive: time,
    );

    final localStorage = GetStorage();

    FirebaseFirestore.instance
        .collection(localStorage.read('Screen'))
        .doc(userCredential.user!.uid)
        .set(newStudent.toJson())
        .then((value) {
          
      SplashService().navigate();

      TLoader.successSnackBar(
        title: 'Congratulation',
        message: 'Your account has been created! Verify email to continue',
      );
    }).onError(
      (error, stackTrace) =>
          TLoader.errorSnackBar(title: 'Oh Snap! ', message: error),
    );
  }
}
