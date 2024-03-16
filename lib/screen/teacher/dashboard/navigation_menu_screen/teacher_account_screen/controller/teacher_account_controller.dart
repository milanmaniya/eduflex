import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_account_screen/teacher_account_screen.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TeacherAccountScreenController extends GetxController {
  static TeacherAccountScreenController get instance => Get.find();

  RxBool isChecked = false.obs;

  RxBool isObsecure = true.obs;

  final localStorage = GetStorage();

  RxString fieldValue = ''.obs;

  final key = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtLatName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtAbout = TextEditingController();

  RxString yearValue = ''.obs;

  final bcaYear = ['FY-BCA', 'SY-BCA', 'TY-BCA'];
  final bbaYear = ['FY-BBA', 'SY-BBA', 'TY-BBA'];

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
      'about': txtAbout.text.trim(),
    }).then((value) {
      TLoader.successSnackBar(
          title: 'Update Data', message: 'Data Updated Successfully');

      Get.off(() => const TeacherAccountScreen());
    }).onError((error, stackTrace) {
      TLoader.errorSnackBar(title: 'Oh Snap! ', message: error.toString());
    });
  }
}
