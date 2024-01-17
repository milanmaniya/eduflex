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
  TextEditingController txtDegree = TextEditingController();
  TextEditingController txtExperience = TextEditingController();
  TextEditingController txtAbout = TextEditingController();

  RxString yearValue = ''.obs;

  final bcaYear = ['FY-BCA', 'SY-BCA', 'TY-BCA'];
  final bbaYear = ['FY-BBA', 'SY-BBA', 'TY-BBA'];
}
