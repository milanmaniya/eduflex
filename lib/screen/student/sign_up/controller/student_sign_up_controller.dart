import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentSignUpController extends GetxController {
  static StudentSignUpController get instance => Get.find();

  RxBool isObsecure = true.obs;

  RxBool isChecked = false.obs;

  final key = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLatName = TextEditingController();
  TextEditingController txtUserName = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  RxString fieldValue = ''.obs;
  RxString yearValue = ''.obs;

  final bcaYear = ['FY-BCA', 'SY-BCA', 'TY-BCA'];
  final bbaYear = ['FY-BBA', 'SY-BBA', 'TY-BBA'];

  // void iaAuthentication() async {
  //   final userCredential =
  //       await AuthenticationReposotiry().registerWithEmailAndPassword(
  //     email: txtEmail.text.trim(),
  //     password: txtPassword.text.trim(),
  //   );

  //   final time = DateTime.now().microsecondsSinceEpoch.toString();

  //   final newTeacher = Teacher(
  //     firstName: txtFirstName.text.trim(),
  //     lastName: txtLatName.text.trim(),
  //     userName: txtUserName.text.trim(),
  //     email: txtEmail.text.trim(),
  //     phoneNumber: txtPhoneNumber.text.trim(),
  //     password: txtPassword.text.trim(),
  //     fieldValue: fieldValue.value,
  //     yearValue: yearValue.value,
  //     isOnline: false,
  //     createAt: time,
  //     image: '',
  //     pushToken: '',
  //     id: userCredential.user!.uid,
  //     about: '',
  //   );

  //   FirebaseFirestore.instance
  //       .collection('Teacher')
  //       .doc(userCredential.user!.uid)
  //       .set(newTeacher.toJson())
  //       .then((value) {
  //     Get.offAll(
  //       () => VerifyEmail(
  //         email: txtEmail.text.trim(),
  //       ),
  //     );

  //     TLoader.successSnackBar(
  //       title: 'Congratulation',
  //       message: 'Your account has been  created! Verify email to continue',
  //     );
  //   }).onError(
  //     (error, stackTrace) =>
  //         TLoader.errorSnackBar(title: 'Oh Snap! ', message: error),
  //   );
  // }
}
