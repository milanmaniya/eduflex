import 'dart:developer';
import 'package:eduflex/screen/teacher/sign_up_screen/sign_up_controller/teacher_sign_up_controller.dart';
import 'package:eduflex/screen/teacher/sign_up_screen/widget/terms_and_condition_text.dart';
import 'package:eduflex/utils/constant/colors.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TeacherSignUpForm extends StatefulWidget {
  const TeacherSignUpForm({
    super.key,
  });

  @override
  State<TeacherSignUpForm> createState() => _TeacherSignUpFormState();
}

class _TeacherSignUpFormState extends State<TeacherSignUpForm> {
  final controller = Get.put(TeacherSignUpController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.txtFirstName,
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
                  controller: controller.txtLastName,
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
            controller: controller.txtUserName,
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
            controller: controller.txtEmailAddress,
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
            controller: controller.txtPhoneNumber,
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
          Obx(
            () => TextFormField(
              controller: controller.txtPassword,
              obscureText: controller.obsecure.value,
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
                    controller.obsecure.value = !controller.obsecure.value;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: TSize.spaceBtwItems,
          ),

          // about
          TextFormField(
            controller: controller.txtAbout,
            decoration: const InputDecoration(
              labelText: TTexts.about,
              prefixIcon: Icon(Iconsax.information),
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
                hint: Text(
                  controller.fieldValue == ''
                      ? 'Can you please select your field'
                      : controller.fieldValue,
                  style: const TextStyle(
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
                onChanged: (value) {
                  setState(() {
                    controller.fieldValue = value!;
                    controller.yearValue = '';
                  });
                  log(controller.fieldValue);
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
                hint: Text(
                  controller.yearValue == ''
                      ? 'Can you please select your year'
                      : controller.yearValue,
                  style: const TextStyle(
                    fontSize: 14,
                    color: TColor.black,
                  ),
                ),
                items: controller.fieldValue == 'BBA'
                    ? controller.bbaYearList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList()
                    : controller.bcaYearList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    controller.yearValue = value!;
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
                if (controller.signUpFormKey.currentState!.validate() &&
                    controller.yearValue.isNotEmpty &&
                    controller.fieldValue.isNotEmpty) {
                  Get.to(() => controller.signUp());
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
