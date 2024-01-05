import 'package:eduflex/common/widget/animation_loader/animation_loader.dart';
import 'package:eduflex/utils/constant/colors.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: THelperFunction.isDarkMode(Get.context!)
              ? TColor.dark
              : TColor.white,
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              AnimationLoader(
                text: text,
                animation: animation,
              ),
            ],
          ),
        ),
        onWillPop: () async {
          return false;
        },
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
