import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/common/widget/success_screen/success_screen.dart';
import 'package:eduflex/screen/home_screen/home_screen.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key, this.email});

  final String? email;

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool? isEmailVerified;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            children: [
              Image(
                image: const AssetImage(
                  'assets/images/verify_email.png',
                ),
                width: THelperFunction.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: TSize.spaceBtwSections,
              ),
              Text(
                TTexts.conformEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              Text(
                widget.email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              Text(
                TTexts.conformEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSize.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    AuthenticationReposotiry()
                        .sendEmailVerification()
                        .then((value) {
                      Logger().i('Email link send successfully');
                    });

                    await FirebaseAuth.instance.currentUser!.reload();

                    setState(() {
                      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
                    });

                    if (isEmailVerified!) {
                      Get.to(
                        () => SucessScreen(
                          imageString: 'assets/animation/Success.gif',
                          pressed: () => Get.offAll(
                            () => const HomeScreen(),
                          ),
                          subTitle: TTexts.yourAccountCreatedSubTitle,
                          title: TTexts.yourAccountCreatedTitle,
                        ),
                      );
                    }
                  },
                  child: const Text(TTexts.tContinue),
                ),
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(TTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
