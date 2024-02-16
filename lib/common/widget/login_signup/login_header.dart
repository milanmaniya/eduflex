import 'package:eduflex/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(
          height: 130,
          image: AssetImage(
            'assets/logo/EduFlex.png',
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: TColor.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
