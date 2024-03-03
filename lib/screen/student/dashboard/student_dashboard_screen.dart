import 'package:eduflex/screen/chat_screen/chat_screen.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_attendance_screen/student_attendance_screen.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_account_screen/student_profile_screen.dart';
import 'package:eduflex/screen/student/dashboard/student_home_screen/student_home_screen.dart';
import 'package:eduflex/utils/helper/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class StudentDashBoardScreen extends StatefulWidget {
  const StudentDashBoardScreen({super.key});

  @override
  State<StudentDashBoardScreen> createState() => _StudentDashBoardScreenState();
}

class _StudentDashBoardScreenState extends State<StudentDashBoardScreen> {
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
                icon: Icon(Iconsax.tag_right), label: 'Attendance'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(
        () => controller.screenList[controller.selectedIndex.value],
      ),
    );
  }
}

class NavigationMenuController extends GetxController {
  final selectedIndex = 0.obs;

  final screenList = [
    const StudentHomeScreen(),
    const ChatScreen(),
    const StudentAttendanceScreen(),
    const StudentProfileScreen(),
  ];
}
