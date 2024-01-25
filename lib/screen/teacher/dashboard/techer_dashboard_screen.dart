import 'package:eduflex/screen/chat_screen/apis/apis.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/home_screen/teacher_home_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_account_screen/teacher_account_screen.dart';
import 'package:eduflex/screen/chat_screen/chat_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_notice_screen.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';

class TeacherDashBoardScreen extends StatefulWidget {
  const TeacherDashBoardScreen({super.key});

  @override
  State<TeacherDashBoardScreen> createState() => _TeacherDashBoardScreenState();
}

class _TeacherDashBoardScreenState extends State<TeacherDashBoardScreen> {
  @override
  void initState() {
    SystemChannels.lifecycle.setMessageHandler((message) {
      Logger().i(message);

      if (message.toString().contains('resume')) APIS.updateActiveStatus(true);
      if (message.toString().contains('pause')) APIS.updateActiveStatus(false);

      return Future.value(message);
    });
    super.initState();
  }

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
            NavigationDestination(icon: Icon(Iconsax.message), label: 'Chat'),
            NavigationDestination(
                icon: Icon(Iconsax.notification), label: 'Notice'),
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
    const ChatScreen(),
    const TeacherNoticeScreen(),
    const TeacherAccountScreen(),
  ];
}
