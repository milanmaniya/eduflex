import 'package:eduflex/common/widget/login_signup/divider.dart';
import 'package:eduflex/common/widget/login_signup/social_buttons.dart';
import 'package:eduflex/screen/student/sign_up_screen/widget/student_sign_up_form.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';

class TeacherSignUpScreen extends StatelessWidget {
  const TeacherSignUpScreen({super.key});

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
              const StudentSignUpForm(),

              const SizedBox(
                height: TSize.spaceBtwSections,
              ),

              // divider
              const FormDivider(dividerText: TTexts.orSignUpWith),

              const SizedBox(
                height: TSize.spaceBtwSections,
              ),
              // social buttons
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
