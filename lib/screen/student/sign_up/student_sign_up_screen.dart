import 'package:eduflex/common/widget/login_signup/login_header.dart';
import 'package:eduflex/screen/student/sign_up/widget/student_sign_up_form.dart';
import 'package:eduflex/utils/constant/colors.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';

class StudentSignUpScreen extends StatefulWidget {
  const StudentSignUpScreen({super.key});

  @override
  State<StudentSignUpScreen> createState() => _StudentSignUpScreenState();
}

class _StudentSignUpScreenState extends State<StudentSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 70,
          left: 15,
          right: 15,
          bottom: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoginHeader(
              title: TTexts.studentLoginTitle,
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
            Expanded(child: StudentSignUpForm()),
          ],
        ),
      ),
    );
  }
}
