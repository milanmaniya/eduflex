import 'package:eduflex/screen/student/widget/student_verify_email_screen.dart';
import 'package:eduflex/screen/teacher/sign_up_screen/widget/terms_and_condition_text.dart';
import 'package:eduflex/utils/constant/colors.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class StudentSignUpForm extends StatefulWidget {
  const StudentSignUpForm({
    super.key,
  });

  @override
  State<StudentSignUpForm> createState() => _StudentSignUpFormState();
}

class _StudentSignUpFormState extends State<StudentSignUpForm> {
  bool isObsecure = true;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            validator: MultiValidator([
              RequiredValidator(errorText: 'Phone number is required'),
            ]),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
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
            validator: MultiValidator([
              RequiredValidator(
                errorText: 'Password is required',
              ),
            ]),
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
            height: TSize.spaceBtwItems,
          ),
          Container(
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: false,
                hint: const Text(
                  'Can you please select your field',
                  style: TextStyle(
                    fontSize: 14,
                    color: TColor.black,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'BBA',
                    child: Text('BBA'),
                  ),
                  DropdownMenuItem(
                    value: 'BCA',
                    child: Text('BCA'),
                  ),
                ],
                onChanged: (value) {},
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
                Get.to(() => const StudentVerifyEmailScreen());
              },
              child: const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
