import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eduflex/network_manager/network_manager.dart';
import 'package:eduflex/utils/popups/full_screen_lodaer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TeacherSignUpController extends GetxController {
  TeacherSignUpController get instance => Get.find();

  RxBool obsecure = true.obs;

  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtEmailAddress = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  GlobalKey<FormState> teacherSignUpFormKey = GlobalKey<FormState>();

  String fieldValue = '';
  String yearValue = '';

  List<String> bcaYearList = ['FYBCA', 'SYBCA', 'TYBCA'];
  List<String> bbaYearList = ['FYBBA', 'SYBBA', 'TYBBA'];

  Future<void> signUp() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        'assets/animation/Loading.gif',
      );

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
    } catch (e) {
      log(e.toString());
    }
  }
}
