import 'dart:developer';
import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/common/widget/phone_number_verification_screen/widget/phone_text_field.dart';
import 'package:eduflex/screen/student/sign_up/student_sign_up_screen.dart';
import 'package:eduflex/screen/teacher/sign_up/teacher_sign_up_screen.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _txtPhoneNumber = TextEditingController();

  final localStorage = GetStorage();

  @override
  void dispose() {
    _txtPhoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: THelperFunction.screenHeight() * 0.40,
                width: THelperFunction.screenWidth() * 0.8,
                margin: EdgeInsets.symmetric(
                  horizontal: THelperFunction.screenWidth() * 0.1,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/animation/otp_send.gif"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: THelperFunction.screenHeight() * 0.02,
              ),
              const Text(
                'Phone Number Verification',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: THelperFunction.screenHeight() * 0.02,
              ),
              const Text(
                'We will send you an one time OTP \n on this given mobile number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: THelperFunction.screenHeight() * 0.02,
              ),
              commonPhoneField(
                controller: _txtPhoneNumber,
                context: context,
                onTap: () {
                  final data = localStorage.read('phoneNumber');

                  log(data.toString());

                  if (data == null) {
                    TLoader.errorSnackBar(
                      title: 'Error',
                      message:
                          'User entered mobile number is not registered, Please firstly register and after that verify the mobile number!',
                      duration: 6,
                    );
                  } else {
                    if (data == _txtPhoneNumber.text) {
                      AuthenticationReposotiry().sendOtp(
                        phoneNumber: _txtPhoneNumber.text,
                        context: context,
                      );
                    } else {
                      TLoader.errorSnackBar(
                        title: 'Error',
                        message:
                            'User entered mobile number is not registered, Please entered the register mobile number',
                        duration: 5,
                      );
                    }
                  }

                  log(_txtPhoneNumber.text);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account ?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final storage = GetStorage();

                      Get.to(
                        () => storage.read('Screen') == 'Teacher'
                            ? const TeacherSignUpScreen()
                            : const StudentSignUpScreen(),
                      );
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
