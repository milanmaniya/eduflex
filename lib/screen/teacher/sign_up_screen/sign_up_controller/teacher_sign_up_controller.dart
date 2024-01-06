import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/network_manager/network_manager.dart';
import 'package:eduflex/utils/popups/full_screen_lodaer.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TeacherSignUpController extends GetxController {
  TeacherSignUpController get instance => Get.find();

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
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog(
        'We are processing your information...',
        'assets/animation/Loading.gif',
      );

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // form validate
      if (!signUpFormKey.currentState!.validate()) {
        return;
      }

      // privacy policy check
      if (!privacyPolicy.value) {
        TLoader.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you want to read and accept the Privacy Policy & Terms of use');
        return;
      }

      // register user in the firebase and save your data in the firebase
     await AuthenticationReposotiry.instance.registerWithEmailAndPassword(
          txtEmailAddress.text.trim(), txtPassword.text.trim());

      //     
    } catch (e) {
      TLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }
}
