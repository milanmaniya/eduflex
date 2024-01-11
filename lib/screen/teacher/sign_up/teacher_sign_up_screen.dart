import 'package:eduflex/common/widget/login_signup/divider.dart';
import 'package:eduflex/common/widget/login_signup/social_buttons.dart';
import 'package:eduflex/screen/teacher/sign_up/widget/teacher_sign_up_form.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(
                height: TSize.spaceBtwSections,
              ),

              // form
              const TeacherSignUpForm(),

              const SizedBox(
                height: TSize.spaceBtwSections,
              ),

              // divider
              const FormDivider(dividerText: TTexts.orSignUpWith),

              const SizedBox(
                height: TSize.spaceBtwSections,
              ),
              // social buttons
              SocialButtons(
                facebook: () {},
                google: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
