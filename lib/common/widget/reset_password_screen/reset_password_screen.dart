import 'package:eduflex/common/widget/forgot_password_screen/forgot_password_screen.dart';
import 'package:eduflex/screen/teacher/login_screen/teacher_login_screen.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            children: [
              Image(
                image: const AssetImage(
                  'assets/images/verify_email.png',
                ),
                width: THelperFunction.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: TSize.spaceBtwSections,
              ),
              Text(
                TTexts.changePasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              Text(
                TTexts.changePasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSize.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.offAll(() => const LoginScreen()),
                  child: const Text(TTexts.done),
                ),
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Get.off(() => const ForgotPassword()),
                  child: const Text(TTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
