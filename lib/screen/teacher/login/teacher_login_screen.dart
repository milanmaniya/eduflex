import 'dart:developer';
import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/common/style/spacing_style.dart';
import 'package:eduflex/common/widget/login_signup/divider.dart';
import 'package:eduflex/common/widget/login_signup/login_header.dart';
import 'package:eduflex/common/widget/login_signup/social_buttons.dart';
import 'package:eduflex/screen/teacher/login/widget/teacher_login_form.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  @override
  void initState() {
    final storage = GetStorage();
    log(storage.read('Screen'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // logo, title, sub-title create
              const LoginHeader(
                title: TTexts.teacherLoginTitle,
                subTitle: TTexts.teacherLoginSubTitle,
              ),

              // form  create
              const TeacherLoginForm(),

              // divider
              const FormDivider(
                dividerText: TTexts.orSignInWith,
              ),

              const SizedBox(
                height: TSize.spaceBtwSections,
              ),

              // footer
              SocialButtons(
                facebook: () {},
                google: () {
                  AuthenticationReposotiry.instance.signInWithGoogle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
