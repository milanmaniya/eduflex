import 'dart:developer';
import 'package:eduflex/common/widget/phone_number_verification_screen/widget/phone_text_field.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _txtPhoneNumber = TextEditingController();

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
                    horizontal: THelperFunction.screenWidth() * 0.1),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/welcome.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: THelperFunction.screenHeight() * 0.02,
              ),
              const Text(
                'OTP Verification',
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
                'We will send you an one time password \n on this given mobile number',
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
                  // FirebaseApiAuth()
                  //     .sendOtp(phoneNumber: _controller.text, context: context);
                  log(_txtPhoneNumber.text);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
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