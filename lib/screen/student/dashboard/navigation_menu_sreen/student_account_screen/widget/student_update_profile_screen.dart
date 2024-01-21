import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eduflex/common/widget/login_signup/terms_and_condition.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_account_screen/controller/studenr_account_controller.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class StudentUpdateProfile extends StatefulWidget {
  const StudentUpdateProfile({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<StudentUpdateProfile> createState() => _StudentUpdateProfileState();
}

class _StudentUpdateProfileState extends State<StudentUpdateProfile> {
  @override
  Widget build(BuildContext context) {
    final instance = Get.put(StudentAccountController());

    instance.fieldValue.value = widget.data['fieldValue'];
    instance.yearValue.value = widget.data['yearValue'];

    setState(() {});

    return Form(
      key: instance.key,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: widget.data['firstName'],
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
                  initialValue: widget.data['lastName'],
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
            initialValue: widget.data['userName'],
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
            initialValue: widget.data['email'],
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
            initialValue: widget.data['phoneNumber'],
            controller: instance.txtPhoneNumber,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            validator: (value) {
              if (value == null) {
                return 'Phone Number is required';
              }

              if (value.length < 10) {
                return 'Phone Number is 10 digit required';
              }
              return null;
            },
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
              initialValue: widget.data['password'],
              validator: (value) {
                if (value == null) {
                  return 'Passowrd is required';
                }

                if (value.length <= 6) {
                  return 'Minimum 6 character password is required';
                }
                return null;
              },
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) => instance.fieldValue.value = value!,
                isExpanded: true,
                hint: Text(
                  instance.fieldValue.isEmpty
                      ? 'Select Item'
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
                      ? 'Select Item'
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
                onChanged: (value) => instance.divValue.value = value!,
                isExpanded: true,
                hint: Text(
                  instance.divValue.isEmpty
                      ? 'Select Item'
                      : instance.divValue.value,
                ),
                items: instance.div
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
                  instance.updateData();
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
