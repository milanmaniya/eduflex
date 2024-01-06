import 'package:eduflex/common/widget/login_signup/divider.dart';
import 'package:eduflex/common/widget/login_signup/social_buttons.dart';
import 'package:eduflex/screen/teacher/login_screen/widget/teacher_login_form.dart';
import 'package:eduflex/common/widget/login_signup/login_header.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';

class TeacherLoginScreen extends StatelessWidget {
  const TeacherLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: TSize.appBarHeight,
            left: TSize.defaultSpace,
            right: TSize.defaultSpace,
            bottom: TSize.defaultSpace,
          ),
          child: Column(
            children: [
              // logo, title, sub-title create
              LoginHeader(
                title: TTexts.teacherLoginTitle,
                subTitle: TTexts.teacherLoginSubTitle,
              ),

              // form  create
              TeacherLoginForm(),

              // divider
              FormDivider(
                dividerText: TTexts.orSignInWith,
              ),

              SizedBox(
                height: TSize.spaceBtwSections,
              ),

              // footer
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
