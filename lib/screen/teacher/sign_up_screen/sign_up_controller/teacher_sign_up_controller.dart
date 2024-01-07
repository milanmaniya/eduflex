import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/screen/teacher/model/teacher_modal.dart';
import 'package:eduflex/screen/teacher/repository/teacher_repository.dart';
import 'package:eduflex/screen/teacher/widget/teacher_verify_email.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TeacherSignUpController extends GetxController {
  static TeacherSignUpController get instance => Get.find();

  RxBool obsecure = true.obs;

  final privacyPolicy = true.obs;

  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtAbout = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtEmailAddress = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  String fieldValue = '';
  String yearValue = '';

  List<String> bcaYearList = ['FYBCA', 'SYBCA', 'TYBCA'];
  List<String> bbaYearList = ['FYBBA', 'SYBBA', 'TYBBA'];

  Future<void> signUp() async {
    // register user in the firebase and save your data in the firebase

    final userCredential = await AuthenticationReposotiry.instance
        .registerWithEmailAndPassword(
            txtEmailAddress.text.trim(), txtPassword.text.trim());

    //    save authticated user data in firebase firestore
    final newUser = Teacher(
        userName: txtUserName.text.trim(),
        email: txtEmailAddress.text.trim(),
        password: txtPassword.text.trim(),
        phoneNumber: txtPhoneNumber.text.trim(),
        field: fieldValue.trim(),
        year: yearValue.trim(),
        firstName: txtFirstName.text.trim(),
        lastName: txtLastName.text.trim(),
        about: txtAbout.text.trim(),
        lastActive: '',
        id: userCredential.user!.uid,
        pushToken: '',
        creatAt: '',
        isOnline: false,
        profilePicture: '');

    final teacherRepository = Get.put(TeacherRepository());
    await teacherRepository.saveTeacherData(newUser);

    // show success message
    TLoader.successSnackBar(
        title: 'Congratulation',
        message: 'Your account has been created! Verify email to contiue.');

    // move to verify email screen
    Get.to(
      () => TeacherVerifyEmailScreen(
        email: txtEmailAddress.text.trim(),
      ),
    );
  }
}



// if (!privacyPolicy.value) {
    //   TLoader.warningSnackBar(
    //       title: 'Accept Privacy Policy',
    //       message:
    //           'In order to create account, you want to read and accept the Privacy Policy & Terms of use');
    // } 