import 'package:eduflex/common/widget/menu_button.dart';
import 'package:eduflex/screen/chat_screen/chat_screen.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_attendance_screen/student_attendance_screen.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_account_screen/student_profile_screen.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_home_screen.dart';
import 'package:eduflex/screen/student/drawer/side_menu.dart';
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
  bool isSideMenuClosed = true;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    final controller = Get.put(NavigationMenuController());

    return Scaffold(
      backgroundColor: const Color(0xFF17203A),
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
        () {
          if (controller.selectedIndex.value == 0) {
            return Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  width: 288,
                  left: isSideMenuClosed ? -288 : 0,
                  height: MediaQuery.of(context).size.height,
                  child: const SideMenuScreen(),
                ),
                Transform.translate(
                  offset: Offset(
                    isSideMenuClosed ? 0 : 288,
                    0,
                  ),
                  child: Transform.scale(
                    scale: isSideMenuClosed ? 1 : 0.8,
                    child: ClipRRect(
                      borderRadius: isSideMenuClosed
                          ? BorderRadius.circular(0)
                          : BorderRadius.circular(20),
                      child: const StudentHomeScreen(),
                    ),
                  ),
                ),
                MenuButtonScreen(
                  onPress: () {
                    setState(() {
                      isSideMenuClosed = !isSideMenuClosed;
                    });
                  },
                ),
              ],
            );
          } else {
            return controller.screenList[controller.selectedIndex.value];
          }
        },
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
