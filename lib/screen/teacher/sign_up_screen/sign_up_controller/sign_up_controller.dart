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
}
