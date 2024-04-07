import 'package:eduflex/common/widget/info_card.dart';
import 'package:eduflex/common/widget/side_menu_card.dart';
import 'package:eduflex/screen/chat_screen/chat_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/home_screen/teacher_home_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_account_screen/teacher_account_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_attendance_screen/teacher_attendance_screen.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherSideMenuScreen extends StatefulWidget {
  const TeacherSideMenuScreen({super.key});

  @override
  State<TeacherSideMenuScreen> createState() => _TeacherSideMenuScreenState();
}

class _TeacherSideMenuScreenState extends State<TeacherSideMenuScreen> {
  List<IconData> iconDataList = [
    CupertinoIcons.home,
    CupertinoIcons.chat_bubble_text_fill,
    CupertinoIcons.chart_bar_alt_fill,
    CupertinoIcons.profile_circled,
  ];

  List<String> iconTittle = [
    'Home',
    'Chat',
    'Attendance',
    'Profile',
  ];

  final screenList = [
    const TeacherHomeScreen(),
    const ChatScreen(),
    const TeacherAttendanceScreen(),
    const TeacherAccountScreen(),
  ];

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: TSize.appBarHeight,
        ),
        width: 288,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InfoCard(
              title: 'Milan Maniya',
              imageUrl: '',
              subTitle: 'TYBCA-SEM6 DIVISON-3',
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                top: 20,
                bottom: 16,
              ),
              child: Text(
                "Browse".toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .apply(color: Colors.white70),
              ),
            ),
            ...List.generate(
              iconTittle.length,
              (index) => SideMenuTile(
                title: iconTittle[index],
                isActive: selectedIndex == index,
                onPress: () {
                  selectedIndex = index;
                  setState(() {});

                  Future.delayed(
                    const Duration(milliseconds: 300),
                    () => Get.to(
                      () => screenList[index],
                      duration: const Duration(milliseconds: 500),
                      transition: Transition.zoom,
                    ),
                  );
                },
                icon: iconDataList[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
