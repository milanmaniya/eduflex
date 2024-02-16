import 'package:eduflex/common/widget/login_signup/login_header.dart';
import 'package:eduflex/screen/teacher/sign_up/widget/teacher_sign_up_form.dart';
import 'package:eduflex/utils/constant/colors.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';

class TeacherSignUpScreen extends StatefulWidget {
  const TeacherSignUpScreen({super.key});

  @override
  State<TeacherSignUpScreen> createState() => _TeacherSignUpScreenState();
}

class _TeacherSignUpScreenState extends State<TeacherSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.only(
            top: 70,
            left: 15,
            right: 15,
            bottom: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              LoginHeader(
                title: TTexts.teacherLoginTitle,
              ),

              SizedBox(
                height: 5,
              ),
              // title
              Text(
                TTexts.signupTitle,
                // style: Theme.of(context).textTheme.headlineMedium,
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: TSize.spaceBtwSections,
              ),

              // form
              TeacherSignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
