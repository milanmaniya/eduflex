import 'package:eduflex/screen/teacher/sign_up_screen/sign_up_controller/teacher_sign_up_controller.dart';
import 'package:eduflex/utils/constant/colors.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionText extends StatefulWidget {
  const TermsAndConditionText({
    super.key,
  });

  @override
  State<TermsAndConditionText> createState() => _TermsAndConditionTextState();
}

class _TermsAndConditionTextState extends State<TermsAndConditionText> {
  @override
  Widget build(BuildContext context) {
    final controller = TeacherSignUpController().instance;

    final dark = THelperFunction.isDarkMode(context);

    return Row(
      children: [
        SizedBox(
          height: 25,
          width: 25,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) {
                controller.privacyPolicy.value =
                    !controller.privacyPolicy.value;
              },
            ),
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${TTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: TTexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColor.white : TColor.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? TColor.white : TColor.primary,
                    ),
              ),
              TextSpan(
                text: ' ${TTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: TTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? TColor.white : TColor.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? TColor.white : TColor.primary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
