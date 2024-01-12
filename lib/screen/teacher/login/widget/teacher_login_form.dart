import 'package:eduflex/common/widget/forgot_password/forgot_password.dart';
import 'package:eduflex/screen/teacher/login/controller/teacher_login_controller.dart';
import 'package:eduflex/screen/teacher/sign_up/teacher_sign_up_screen.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TeacherLoginForm extends StatefulWidget {
  const TeacherLoginForm({super.key});

  @override
  State<TeacherLoginForm> createState() => _TeacherLoginFormState();
}

class _TeacherLoginFormState extends State<TeacherLoginForm> {
  @override
  Widget build(BuildContext context) {
    final instance = Get.put(TeacherLoginController());

    return Form(
      key: instance.key,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: TSize.spaceBtwSections,
        ),
        child: Column(
          children: [
            // email
            TextFormField(
              validator: MultiValidator([
                RequiredValidator(errorText: 'Email is required'),
                EmailValidator(errorText: 'Email is not a valid format'),
              ]),
              controller: instance.txtEmail,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
            ),

            const SizedBox(
              height: TSize.spaceBtwItems,
            ),
            // password
            Obx(
              () => TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Password is required'),
                ]),
                controller: instance.txtPassword,
                obscureText: instance.isObsecure.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    icon: Icon(instance.isObsecure.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                    onPressed: () =>
                        instance.isObsecure.value = !instance.isObsecure.value,
                  ),
                  labelText: TTexts.password,
                ),
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
                    Obx(
                      () => Checkbox(
                        value: instance.isChecked.value,
                        onChanged: (value) => instance.isChecked.value =
                            !instance.isChecked.value,
                      ),
                    ),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                //Forgot Password

                TextButton(
                  onPressed: () => Get.to(() => const ForgotPassword()),
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
                onPressed: () {
                  if (instance.key.currentState!.validate()) {
                    instance.isAuthentication();
                  }
                },
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
