import 'dart:developer';
import 'package:eduflex/common/style/spacing_style.dart';
import 'package:eduflex/common/widget/login_signup/divider.dart';
import 'package:eduflex/common/widget/login_signup/login_header.dart';
import 'package:eduflex/common/widget/login_signup/social_buttons.dart';
import 'package:eduflex/screen/student/login/controller/student_login_controller.dart';
import 'package:eduflex/screen/student/login/widget/student_login_form.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  @override
  void initState() {
    final storage = GetStorage();
    log(storage.read('Screen'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final instance = Get.put(StudentLoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // logo, title, sub-title create
              const LoginHeader(
                title: TTexts.studentLoginTitle,
              
              ),

              // form  create
              const StudentLoginForm(),

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
                  instance.iaGoogleAuthentication();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
