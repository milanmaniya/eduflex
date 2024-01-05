import 'package:eduflex/utils/constant/colors.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';

class AnimationLoader extends StatelessWidget {
  const AnimationLoader({
    super.key,
    required this.text,
    required this.animation,
    this.actionText,
    this.showAction = false,
    this.onActionPreseed,
  });

  final String text;
  final String animation;
  final String? actionText;
  final bool showAction;
  final VoidCallback? onActionPreseed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            animation,
            width: THelperFunction.screenWidth() * 0.8,
          ),
          const SizedBox(
            height: TSize.defaultSpace,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: TSize.defaultSpace,
          ),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPreseed,
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColor.grey),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
