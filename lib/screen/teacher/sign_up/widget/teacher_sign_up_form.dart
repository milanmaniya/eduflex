import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eduflex/common/widget/login_signup/terms_and_condition.dart';
import 'package:eduflex/screen/teacher/sign_up/controller/teacher_sign_up_controller.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:form_validator/form_validator.dart';
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
  @override
  Widget build(BuildContext context) {
    final instance = Get.put(TeacherSignUpController());

    return Form(
      key: instance.key,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: instance.txtFirstName,
                  validator: ValidationBuilder().required().build(),
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
                  controller: instance.txtLatName,
                  validator: ValidationBuilder().required().build(),
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
            controller: instance.txtUserName,
            validator: ValidationBuilder().required().build(),
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
            controller: instance.txtEmail,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Email is required'),
              EmailValidator(errorText: 'Email is not a valid format'),
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
            controller: instance.txtPhoneNumber,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            validator: ValidationBuilder().phone().build(),
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
              validator: MultiValidator([
                RangeValidator(
                    min: 6,
                    max: 18,
                    errorText: 'Minumum 6 character are required'),
                RequiredValidator(errorText: 'Password is required'),
              ]),
              controller: instance.txtPassword,
              obscureText: instance.isObsecure.value,
              decoration: InputDecoration(
                labelText: TTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: Icon(instance.isObsecure.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                  onPressed: () =>
                      instance.isObsecure.value = !instance.isObsecure.value,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: TSize.spaceBtwItems,
          ),

          Obx(
            () => SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) => instance.fieldValue.value = value!,
                isExpanded: true,
                hint: Text(
                  instance.fieldValue.isEmpty
                      ? 'Select Your Field'
                      : instance.fieldValue.value,
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
              ),
            ),
          ),

          const SizedBox(
            height: TSize.spaceBtwItems,
          ),

          Obx(
            () => SizedBox(
              width: double.infinity,
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) => instance.yearValue.value = value!,
                isExpanded: true,
                hint: Text(
                  instance.yearValue.isEmpty
                      ? 'Select Your Year'
                      : instance.yearValue.value,
                ),
                items: instance.fieldValue.value == 'BBA'
                    ? instance.bbaYear
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList()
                    : instance.bcaYear
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),

          const SizedBox(
            height: TSize.spaceBtwItems,
          ),

          // degree
          TextFormField(
            controller: instance.txtDegree,
            validator: ValidationBuilder().required().build(),
            decoration: const InputDecoration(
              labelText: TTexts.degree,
              prefixIcon: Icon(Iconsax.information),
            ),
          ),

          const SizedBox(
            height: TSize.spaceBtwItems,
          ),

          // experince
          TextFormField(
            controller: instance.txtExperience,
            validator: ValidationBuilder().required().build(),
            decoration: const InputDecoration(
              labelText: TTexts.experience,
              prefixIcon: Icon(Iconsax.information),
            ),
          ),

          const SizedBox(
            height: TSize.spaceBtwItems,
          ),

          // About
          TextFormField(
            controller: instance.txtAbout,
            validator: ValidationBuilder().required().build(),
            decoration: const InputDecoration(
              labelText: TTexts.about,
              prefixIcon: Icon(Iconsax.info_circle),
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
                if (instance.key.currentState!.validate()) {
                  instance.iaAuthentication();
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
