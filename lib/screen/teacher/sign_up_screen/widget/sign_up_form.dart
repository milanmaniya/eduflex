import 'package:eduflex/screen/teacher/sign_up_screen/widget/terms_and_condition_text.dart';
import 'package:eduflex/screen/teacher/verify_email_screen/verify_email_screen.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isObsecure = true;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(
                width: TSize.spaceBtwItems,
              ),
              Expanded(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSize.spaceBtwItems,
          ),

          // username
          TextFormField(
            validator: MultiValidator([
              RequiredValidator(errorText: 'UserName fill is required'),
            ]),
            decoration: const InputDecoration(
              labelText: TTexts.userName,
              prefixIcon: Icon(Iconsax.user_tick),
            ),
          ),
          const SizedBox(
            height: TSize.spaceBtwItems,
          ),

          // Email
          TextFormField(
            validator: MultiValidator([
              EmailValidator(errorText: 'This Email is not valid '),
              RequiredValidator(errorText: 'Email id fill is required'),
            ]),
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: TSize.spaceBtwItems,
          ),
          // phone number
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            // validator: (value) {
            //   if (value == null || value.isNotEmpty) {
            //     return 'Phone Number is required';
            //   }

            //   final phoneRegExp = RegExp(r'^\d{10}$');

            //   if (!phoneRegExp.hasMatch(value)) {
            //     return 'Invalid phone number format (10 digit required)';
            //   }
            //   return null;
            // },
            decoration: const InputDecoration(
              labelText: TTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),

          const SizedBox(
            height: TSize.spaceBtwItems,
          ),

          //password
          TextFormField(
            obscureText: isObsecure,
            decoration: InputDecoration(
              labelText: TTexts.password,
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                icon: const Icon(Iconsax.eye_slash),
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
              ),
            ),
          ),

          const SizedBox(
            height: TSize.spaceBtwSections,
          ),

          // Terms and condition checkbox

          const TermsAndConditionText(),

          const SizedBox(
            height: TSize.spaceBtwSections,
          ),

          // signup button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  Get.to(() => const VerifyEmailScreen());
                }
              },
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
