import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class TeacherLoginController extends GetxController {
  static TeacherLoginController get instance => Get.find();

  RxBool isObsecure = true.obs;

  RxBool isChecked = false.obs;

  final localStorage = GetStorage();

  final key = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  void onInit() {
    Logger().i(localStorage.read('REMEMBER_ME_EMAIL'));
    Logger().i(localStorage.read('REMEMBER_ME_PASSWORD'));

    txtEmail.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    txtPassword.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  void isAuthentication() async {
    if (isChecked.value) {
      localStorage.write('REMEMBER_ME_EMAIL', txtEmail.text.trim());
      localStorage.write('REMEMBER_ME_PASSWORD', txtPassword.text.trim());
    }

    await AuthenticationReposotiry()
        .loginWithEmailIdAndPassword(
            email: txtEmail.text.trim(), password: txtPassword.text.trim())
        .then((value) {
      Get.offAll(() => const HomeScreen());
    });
  }
}
