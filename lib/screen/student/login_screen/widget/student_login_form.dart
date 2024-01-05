import 'dart:developer';
import 'package:eduflex/screen/student/widget/student_forgot_password_screen.dart';
import 'package:eduflex/screen/teacher/sign_up_screen/teacher_sign_up_screen.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class StudentLoginForm extends StatefulWidget {
  const StudentLoginForm({
    super.key,
  });

  @override
  State<StudentLoginForm> createState() => _StudentLoginFormState();
}

class _StudentLoginFormState extends State<StudentLoginForm> {
  bool isObset = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: TSize.spaceBtwSections,
        ),
        child: Column(
          children: [
            // email
            TextFormField(
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
              obscureText: isObset,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: const Icon(Iconsax.eye_slash),
                  onPressed: () {
                    setState(() {
                      isObset = !isObset;
                      log(isObset.toString());
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
                  onPressed: () => Get.to(() => const StudentForgotPassword()),
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
