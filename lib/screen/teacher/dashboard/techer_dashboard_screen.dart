import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/home_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_account_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_chat_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_notice_screen.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TeacherDashBoardScreen extends StatefulWidget {
  const TeacherDashBoardScreen({super.key});

  @override
  State<TeacherDashBoardScreen> createState() => _TeacherDashBoardScreenState();
}

class _TeacherDashBoardScreenState extends State<TeacherDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    final controller = Get.put(NavigationMenuController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 75,
          elevation: 0,
          backgroundColor: dark ? Colors.black : Colors.white,
          indicatorColor: dark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.1),
          onDestinationSelected: (value) =>
              controller.selectedIndex.value = value,
          selectedIndex: controller.selectedIndex.value,
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Chat'),
            NavigationDestination(icon: Icon(Iconsax.heart), label: 'Notice'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(
        () => Center(
          child: controller.screenList[controller.selectedIndex.value],
        ),
      ),
    );
  }
}

class NavigationMenuController extends GetxController {
  final selectedIndex = 0.obs;

  final screenList = [
    const TeacherHomeScreen(),
    const TeacherChatScreen(),
    const TeacherNoticeScreen(),
    const TeacherAccountScreen(),
  ];
}
