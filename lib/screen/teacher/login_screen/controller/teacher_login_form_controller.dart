import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TeacherLoginFormController extends GetxController {
  TeacherLoginFormController get instance => Get.find();
  
  TextEditingController txtLoginEmail = TextEditingController();
  TextEditingController txtLoginPassword = TextEditingController();
}
