import 'package:eduflex/utils/constant/colors.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? TColor.darkGrey : TColor.grey,
            thickness: 1,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          dividerText.capitalize!,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? TColor.darkGrey : TColor.grey,
            thickness: 1,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
