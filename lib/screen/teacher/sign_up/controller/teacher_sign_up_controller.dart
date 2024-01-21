import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/screen/splash%20_screen/splash_service.dart';
import 'package:eduflex/screen/teacher/model/teacher_model.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class TeacherSignUpController extends GetxController {
  static TeacherSignUpController get instance => Get.find();

  RxBool isObsecure = true.obs;

  RxBool isChecked = false.obs;

  final key = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLatName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtDegree = TextEditingController();
  TextEditingController txtExperience = TextEditingController();
  TextEditingController txtAbout = TextEditingController();

  RxString fieldValue = ''.obs;
  RxString yearValue = ''.obs;

  final bcaYear = ['FY-BCA', 'SY-BCA', 'TY-BCA'];
  final bbaYear = ['FY-BBA', 'SY-BBA', 'TY-BBA'];

  void iaAuthentication() async {
    final userCredential =
        await AuthenticationReposotiry().registerWithEmailAndPassword(
      email: txtEmail.text.trim(),
      password: txtPassword.text.trim(),
    );

    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final newTeacher = Teacher(
      firstName: txtFirstName.text.trim(),
      lastName: txtLatName.text.trim(),
      userName: txtUserName.text.trim(),
      email: txtEmail.text.trim(),
      phoneNumber: txtPhoneNumber.text.trim(),
      password: txtPassword.text.trim(),
      fieldValue: fieldValue.value,
      yearValue: yearValue.value,
      isOnline: false,
      createAt: time,
      image: userCredential.user!.photoURL ?? '',
      pushToken: '',
      id: userCredential.user!.uid,
      about: txtAbout.text.trim(),
      degree: txtDegree.text.trim(),
      experince: txtExperience.text.trim(),
    );

    final localStorage = GetStorage();

    connectUser(id: userCredential.user!.uid);

    FirebaseFirestore.instance
        .collection(localStorage.read('Screen'))
        .doc(userCredential.user!.uid)
        .set(newTeacher.toJson())
        .then((value) {
      SplashService().navigate();

      TLoader.successSnackBar(
        title: 'Congratulation',
        message: 'Your account has been created! Verify email to continue',
      );
    }).onError(
      (error, stackTrace) =>
          TLoader.errorSnackBar(title: 'Oh Snap! ', message: error),
    );
  }

  Future<void> connectUser({required String id}) async {
    await ZIMKit().connectUser(
      id: id,
      name: txtUserName.text.trim(),
    );
  }
}
