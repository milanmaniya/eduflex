import 'dart:developer';
import 'package:eduflex/screen/teacher/login_screen/login_screen.dart';
import 'package:eduflex/utils/constant/colors.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: TSize.defaultSpace,
          vertical: TSize.appBarHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome",
              style: Theme.of(context).textTheme.headlineLarge!.apply(
                    color: TColor.black.withOpacity(0.85),
                  ),
            ),
            const SizedBox(
              height: TSize.spaceBtwSections,
            ),
            Image.asset(
              'assets/images/welcome.png',
            ),
            const Spacer(),
            const SizedBox(
              height: TSize.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const LoginScreen());
                },
                child: const Text(
                  "Teacher",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: TSize.spaceBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  log('Student screen navigate');
                },
                child: const Text(
                  "Student",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
