import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherLoginController extends GetxController {
  static TeacherLoginController get instance => Get.find();

  RxBool isObsecure = true.obs;

  RxBool isChecked = false.obs;

  final key = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
}
