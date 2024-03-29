import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentAccountController extends GetxController {
  static StudentAccountController get instance => Get.find();

  final localStorage = GetStorage();

  RxBool isObsecure = true.obs;

  RxBool isChecked = false.obs;

  final key = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLatName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtAbout = TextEditingController();

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
    'DIV-1',
    'DIV-2',
    'DIV-3',
    'DIV-4',
  ];

  Future<void> updateData(BuildContext context, String id) async {
    await FirebaseFirestore.instance.collection('Student').doc(id).update({
      'lastName': txtLatName.text.trim(),
      'firstName': txtFirstName.text.trim(),
      'email': txtEmail.text.trim(),
      'password': txtPassword.text.trim(),
      'userName': txtUserName.text.trim(),
      'fieldValue': fieldValue.value.trim(),
      'yearValue': yearValue.value.trim(),
      'div': divValue.value.trim(),
      'about': txtAbout.text.trim(),
    }).then((value) {
      TLoader.successSnackBar(
          title: 'Update Data', message: 'Data Updated Successfully');

      Navigator.pop(context);
    }).onError((error, stackTrace) {
      TLoader.errorSnackBar(title: 'Oh Snap! ', message: error.toString());
    });
  }
}
