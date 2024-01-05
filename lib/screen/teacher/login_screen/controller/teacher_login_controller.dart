import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TeacherLoginController extends GetxController {
  TeacherLoginController get instance => Get.find();

  TextEditingController txtLoginEmail = TextEditingController();
  TextEditingController txtLoginPassword = TextEditingController();
}
