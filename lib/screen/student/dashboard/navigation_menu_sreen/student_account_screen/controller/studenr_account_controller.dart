import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_account_screen/student_profile_screen.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentAccountController extends GetxController {
  static StudentAccountController get instance => Get.find();

  final localStorage = GetStorage();

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

  Future<void> updateData() async {
    await FirebaseFirestore.instance
        .collection(localStorage.read('Screen'))
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'lastName': txtLatName.text.trim(),
      'firstName': txtFirstName.text.trim(),
      'email': txtEmail.text.trim(),
      'password': txtPassword.text.trim(),
      'userName': txtUserName.text.trim(),
      'fieldValue': fieldValue.value.trim(),
      'yearValue': yearValue.value.trim(),
      'divValue': divValue.value.trim(),
      'phoneNumber': txtPhoneNumber.text.trim(),
      'about': txtAbout.text.trim(),
    }).then((value) {
      TLoader.successSnackBar(
          title: 'Update Data', message: 'Data Updated Successfully');

      Get.off(() => const StudentProfileScreen());
    }).onError((error, stackTrace) {
      TLoader.errorSnackBar(title: 'Oh Snap! ', message: error.toString());
    });
  }
}
