import 'package:eduflex/utils/constant/colors.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key, required this.google, required this.facebook,
  });

  final VoidCallback google;
  final VoidCallback facebook;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: TColor.grey,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: google,
            icon: const Icon(Bootstrap.google),
          ),
        ),
        const SizedBox(
          width: TSize.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: TColor.grey,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: facebook,
            icon: const Icon(Bootstrap.facebook),
          ),
        ),
      ],
    );
  }
}
