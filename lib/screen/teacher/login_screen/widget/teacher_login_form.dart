import 'dart:developer';
import 'package:eduflex/screen/teacher/login_screen/controller/teacher_login_controller.dart';
import 'package:eduflex/screen/teacher/sign_up_screen/teacher_sign_up_screen.dart';
import 'package:eduflex/screen/teacher/widget/teacher_forgot_password.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TeacherLoginForm extends StatefulWidget {
  const TeacherLoginForm({
    super.key,
  });

  @override
  State<TeacherLoginForm> createState() => _TeacherLoginFormState();
}

class _TeacherLoginFormState extends State<TeacherLoginForm> {
  final controller = Get.put(TeacherLoginController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginFromKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: TSize.spaceBtwSections,
        ),
        child: Column(
          children: [
            // email
            TextFormField(
              controller: controller.txtLoginEmail,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),
            const SizedBox(
              height: TSize.spaceBtwItems,
            ),
            // password
            TextFormField(
              obscureText: controller.obset.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: const Icon(Iconsax.eye_slash),
                  onPressed: () {
                    setState(() {
                      controller.obset.value = !controller.obset.value;
                      log(controller.obset.value.toString());
                    });
                  },
                ),
                labelText: TTexts.password,
              ),
            ),
            const SizedBox(
              height: TSize.spaceBtwItems / 2,
            ),

            // Remember Me and forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Remember Me
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                    ),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                //Forgot Password

                TextButton(
                  onPressed: () => Get.to(() => const TeacherForgotPassword()),
                  child: const Text(TTexts.forgotPassword),
                ),
              ],
            ),
            const SizedBox(
              height: TSize.spaceBtwSections,
            ),

            // signin button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // onPressed: () => Get.to(
                //   () => const NavigationMenu(),
                // ),
                onPressed: () {},
                child: const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(
              height: TSize.spaceBtwItems,
            ),

            // Create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.to(() => const TeacherSignUpScreen());
                },
                child: const Text(TTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
