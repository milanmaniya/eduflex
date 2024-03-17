// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/common/widget/login_signup/terms_and_condition.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_account_screen/controller/studenr_account_controller.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

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
  String? _image;

  @override
  Widget build(BuildContext context) {
    final instance = Get.put(StudentAccountController());

    instance.fieldValue.value = widget.data['fieldValue'];
    String id = widget.data['id'];
    instance.txtAbout.text = widget.data['about'];
    instance.yearValue.value = widget.data['yearValue'];
    instance.divValue.value = widget.data['div'];
    instance.txtFirstName.text = widget.data['firstName'];
    instance.txtLatName.text = widget.data['lastName'];
    instance.txtUserName.text = widget.data['userName'];
    instance.txtEmail.text = widget.data['email'];
    instance.txtPassword.text = widget.data['password'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Edit Profile',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(
          top: 10,
          left: 15,
          right: 15,
          bottom: 20,
        ),
        child: Form(
          key: instance.key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _showModalSheet();
                },
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          File(_image!),
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 120,
                          width: 120,
                          imageUrl: widget.data['image'],
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                            child: Icon(Iconsax.people),
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: TSize.spaceBtwSections,
              ),
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

              //password
              Obx(
                () => TextFormField(
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
                      onPressed: () => instance.isObsecure.value =
                          !instance.isObsecure.value,
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
                    onChanged: (value) {
                      instance.fieldValue.value = value!;

                      instance.yearValue.value = '';
                    },
                    isExpanded: true,
                    hint: Text(
                      instance.fieldValue.isEmpty
                          ? 'Select Field'
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
                          ? 'Select Year'
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
                          ? 'Select Divison'
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
                height: TSize.spaceBtwItems,
              ),

              TextFormField(
                controller: instance.txtAbout,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'about is required'),
                ]),
                decoration: const InputDecoration(
                  labelText: TTexts.about,
                  prefixIcon: Icon(Iconsax.information),
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
                      instance.updateData(context, id);
                    }
                  },
                  child: const Text(TTexts.updateAccount),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModalSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
          left: 15,
          right: 15,
          top: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Pick Profile Picture',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: TSize.spaceBtwItems,
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 60,
            //   child: ElevatedButton.icon(
            //     icon: const Icon(Iconsax.camera),
            //     onPressed: () async {
            //       final ImagePicker picker = ImagePicker();
            //       final XFile? image = await picker.pickImage(
            //         source: ImageSource.camera,
            //       );
            //       if (image != null) {
            //         log(image.path.toString());

            //         setState(() {
            //           _image = image.path;
            //         });

            //         APIS
            //             .updateProfilePicture(File(_image!), widget.data['id'])
            //             .then((value) {
            //           TLoader.successSnackBar(
            //             title: 'Congratulation',
            //             message: 'Your Profile Picture is updated',
            //           );
            //         });

            //         Navigator.pop(context);
            //       }
            //     },
            //     label: const Text('Camera'),
            //   ),
            // ),
            // const SizedBox(
            //   height: TSize.spaceBtwItems,
            // ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                icon: const Icon(Iconsax.gallery),
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    log(image.path.toString());

                    setState(() {
                      _image = image.path;
                    });

                    APIS
                        .updateProfilePicture(File(_image!), widget.data['id'])
                        .then((value) {
                      TLoader.successSnackBar(
                        title: 'Congratulation',
                        message: 'Your Profile Picture is updated',
                      );
                    });

                    Navigator.pop(context);
                  }
                },
                label: const Text('Gallery'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
