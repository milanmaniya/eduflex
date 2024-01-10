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
  RxString divValue = ''.obs;


  final bcaYear = [
    'FY-BCA SEM-1',
    'FY-BCA SEM-2',
    'SY-BCA SEM-3',
    'SY-BCA SEM-4',
    'TY-BCA SEM-5',
    'TY-BCA SEM-6',
  ];
  final bbaYear = [
    'FY-BBA SEM-1',
    'FY-BBA SEM-2',
    'SY-BBA SEM-3',
    'SY-BBA SEM-4',
    'TY-BBA SEM-5',
    'TY-BBA SEM-6',
  ];

  final div = [
    'DIV-1',
    'DIV-2',
    'DIV-3',
    'DIV-4',
  ];

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
