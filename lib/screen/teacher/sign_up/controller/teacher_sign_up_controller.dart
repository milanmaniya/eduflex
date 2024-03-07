import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherSignUpController extends GetxController {
  static TeacherSignUpController get instance => Get.find();

  RxBool isObsecure = true.obs;

  RxBool isChecked = false.obs;

  final key = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLatName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtDegree = TextEditingController();
  TextEditingController txtExperience = TextEditingController();
  TextEditingController txtAbout = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();

  RxString fieldValue = ''.obs;
  RxString yearValue = ''.obs;

  final bcaYear = ['FY-BCA', 'SY-BCA', 'TY-BCA'];
  final bbaYear = ['FY-BBA', 'SY-BBA', 'TY-BBA'];
}
