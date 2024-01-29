import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/constant/text_strings.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SucessScreen extends StatefulWidget {
  const SucessScreen(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.imageString,
      required this.pressed});

  final String title, subTitle, imageString;
  final VoidCallback? pressed;

  @override
  State<SucessScreen> createState() => _SucessScreenState();
}

class _SucessScreenState extends State<SucessScreen> {
  @override
  void initState() {
    final localStorage = GetStorage();

    localStorage.write('phoneVerify', true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: TSize.appBarHeight,
            bottom: TSize.defaultSpace,
            left: TSize.defaultSpace,
            right: TSize.defaultSpace,
          ),
          child: Column(
            children: [
              Image(
                image: AssetImage(
                  widget.imageString,
                ),
                width: THelperFunction.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: TSize.spaceBtwSections,
              ),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              Text(
                widget.subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSize.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.pressed,
                  child: const Text(TTexts.tContinue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
