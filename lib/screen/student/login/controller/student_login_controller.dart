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

}
