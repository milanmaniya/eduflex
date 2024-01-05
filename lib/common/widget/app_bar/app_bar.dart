import 'package:eduflex/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    super.key,
    this.titles,
    this.leadingIcon,
    this.showBackArrow = false,
    this.action,
    this.leadingOnPressed,
  });

  final Widget? titles;
  final IconData? leadingIcon;
  final bool showBackArrow;
  final List<Widget>? action;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TSize.md,
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: titles,
        actions: action,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Iconsax.arrow_left),
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadingIcon),
                  )
                : null,
      ),
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}
