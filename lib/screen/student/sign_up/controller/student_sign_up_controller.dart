import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentSignUpController extends GetxController {
  static StudentSignUpController get instance => Get.find();

  RxBool isObsecure = true.obs;

  RxBool isChecked = false.obs;

  final key = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLatName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtAbout = TextEditingController();
  TextEditingController txtRollNo = TextEditingController();

  RxString fieldValue = ''.obs;
  RxString yearValue = ''.obs;
  RxString divValue = ''.obs;

  final bcaYear = [
    'FYBCA-SEM1',
    'FYBCA-SEM2',
    'SYBCA-SEM3',
    'SYBCA-SEM4',
    'TYBCA-SEM5',
    'TYBCA-SEM6',
  ];
  final bbaYear = [
    'FYBBA-SEM1',
    'FYBBA-SEM2',
    'SYBBA-SEM3',
    'SYBBA-SEM4',
    'TYBBA-SEM5',
    'TYBBA-SEM6',
  ];

  final div = [
    'Divison-1',
    'Divison-2',
    'Divison-3',
    'Divison-4',
  ];
}
