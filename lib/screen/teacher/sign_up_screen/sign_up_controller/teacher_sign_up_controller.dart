import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TeacherSignUpFormController extends GetxController {
  TeacherSignUpFormController get instance => Get.find();

  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtEmailAddress = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  String fieldValue = '';
  String yearValue = '';

  List<String> bcaYearList = ['FYBCA', 'SYBCA', 'TYBCA'];
  List<String> bbaYearList = ['FYBBA', 'SYBBA', 'TYBBA'];
}
