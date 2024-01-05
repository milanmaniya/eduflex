import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TeacherLoginController extends GetxController {
  TeacherLoginController get instance => Get.find();

  RxBool obset = true.obs;

  GlobalKey<FormState> loginFromKey = GlobalKey<FormState>();

  TextEditingController txtLoginEmail = TextEditingController();
  TextEditingController txtLoginPassword = TextEditingController();
}
