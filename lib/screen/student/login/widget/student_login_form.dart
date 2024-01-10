import 'package:eduflex/screen/home_screen/home_screen.dart';
import 'package:eduflex/screen/student/login/controller/student_login_controller.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class StudentLoginForm extends StatefulWidget {
  const StudentLoginForm({super.key});

  @override
  State<StudentLoginForm> createState() => _StudentLoginFormState();
}

class _StudentLoginFormState extends State<StudentLoginForm> {
  @override
  Widget build(BuildContext context) {
    final instance = Get.put(StudentLoginController());

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
                  onPressed: () {},
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
                    Get.to(
                      () => const HomeScreen(),
                    );
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
