import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TeacherSignUpController extends GetxController {
  TeacherSignUpController get instance => Get.find();

  RxBool obsecure = true.obs;

  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtEmailAddress = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  GlobalKey<FormState> teacherSignUpFormKey = GlobalKey<FormState>();

  String fieldValue = '';
  String yearValue = '';

  List<String> bcaYearList = ['FYBCA', 'SYBCA', 'TYBCA'];
  List<String> bbaYearList = ['FYBBA', 'SYBBA', 'TYBBA'];

  Future<void> signUp() async {
    try {

      // start loading

      


    } catch (e) {
      log(e.toString());
    }
  }
}
