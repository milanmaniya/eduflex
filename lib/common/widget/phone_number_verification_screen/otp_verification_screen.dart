import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/splash%20_screen/splash_service.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen(
      {super.key, required this.verificationId, required this.phoneNumber});

  final String verificationId;
  final String phoneNumber;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final OtpFieldController _txtOtp = OtpFieldController();

  final localStorage = GetStorage();

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
                    image: AssetImage(
                      "assets/animation/otp_send.gif",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: THelperFunction.screenHeight() * 0.02,
              ),
              const Text(
                'Otp Verification',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: THelperFunction.screenHeight() * 0.010,
              ),
              const Text(
                'Please Enter the OTP send to you',
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
              OTPTextField(
                margin: const EdgeInsets.symmetric(vertical: 15),
                controller: _txtOtp,
                length: 6,
                width: THelperFunction.screenWidth() * 0.95,
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                fieldWidth: 45,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: const TextStyle(fontSize: 17),
                onChanged: (value) {},
                onCompleted: (pin) {
                  TTexts.otpPinValue = pin;
                  Logger().i(pin.toString());
                },
              ),
              SizedBox(
                height: THelperFunction.screenHeight() * 0.02,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Didn't receive the otp?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'RESEND OTP',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(7),
                  minimumSize: MaterialStateProperty.all(
                    Size(
                      THelperFunction.screenWidth() * 0.9,
                      THelperFunction.screenHeight() * 0.060,
                    ),
                  ),
                ),
                onPressed: () {
                  AuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: TTexts.otpPinValue,
                  );
                  FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((value) {
                    TLoader.successSnackBar(
                      title: 'Congratulation',
                      message: 'Phone Number Verified Successfully!',
                    );

                    final data = localStorage.read('Student');

                    log(data.toString());

                    FirebaseFirestore.instance
                        .collection(localStorage.read('Screen'))
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set(data.toJson())
                        .then((value) {
                      SplashService().navigate();

                      TLoader.successSnackBar(
                        title: 'Congratulation',
                        message: 'Your account has been created succesfully',
                      );
                    }).onError(
                      (error, stackTrace) => TLoader.errorSnackBar(
                          title: 'Oh Snap! ', message: error),
                    );
                  });
                },
                child: const Text(
                  "Verify",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
