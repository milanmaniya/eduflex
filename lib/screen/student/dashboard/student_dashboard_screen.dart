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

class _StudentDashBoardScreenState extends State<StudentDashBoardScreen>
    with SingleTickerProviderStateMixin {
  bool isSideMenuClosed = true;

  late AnimationController _animationController;

  late Animation<double> animation;
  late Animation<double> scalAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Curves.fastOutSlowIn,
        parent: _animationController,
      ),
    );

    scalAnimation = Tween<double>(
      begin: 1,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        curve: Curves.fastOutSlowIn,
        parent: _animationController,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);

    final controller = Get.put(NavigationMenuController());

    return Scaffold(
      backgroundColor: const Color(0xFF17203A),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: Obx(
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
      ),
      body: Obx(
        () {
          if (controller.selectedIndex.value == 0) {
            return Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  width: 288,
                  left: isSideMenuClosed ? -288 : 0,
                  height: MediaQuery.of(context).size.height,
                  child: const SideMenuScreen(),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(
                        animation.value - 30 * animation.value * 3.14 / 180),
                  child: Transform.translate(
                    offset: Offset(
                      animation.value * 265,
                      0,
                    ),
                    child: Transform.scale(
                      scale: scalAnimation.value,
                      child: ClipRRect(
                        borderRadius: isSideMenuClosed
                            ? BorderRadius.circular(0)
                            : BorderRadius.circular(20),
                        child: const StudentHomeScreen(),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  left: isSideMenuClosed ? 0 : 220,
                  child: MenuButtonScreen(
                    isMenu: isSideMenuClosed,
                    onPress: () {
                      if (isSideMenuClosed) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                      setState(() {
                        isSideMenuClosed = !isSideMenuClosed;
                      });
                    },
                  ),
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
