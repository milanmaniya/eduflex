import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/common/widget/info_card.dart';
import 'package:eduflex/common/widget/side_menu_card.dart';
import 'package:eduflex/screen/chat_screen/chat_screen.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_account_screen/student_profile_screen.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_attendance_screen/student_attendance_screen.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_home_screen.dart';
import 'package:eduflex/screen/student/fees_screen/fees_screen.dart';
import 'package:eduflex/screen/student/library_screens/google_library.dart';
import 'package:eduflex/screen/student/tech_news_screens/tech_news_screen.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StudentSideMenuScreen extends StatefulWidget {
  const StudentSideMenuScreen({super.key});

  @override
  State<StudentSideMenuScreen> createState() => _StudentSideMenuScreenState();
}

class _StudentSideMenuScreenState extends State<StudentSideMenuScreen> {
  Map<String, dynamic> userInfo = {};

  final localStorage = GetStorage();

  Future<void> getInfoDetails() async {
    final data = await FirebaseFirestore.instance
        .collection('Student')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      userInfo.addAll(data.data() as Map<String, dynamic>);
    });
  }

  List<IconData> iconDataList = [
    CupertinoIcons.home,
    CupertinoIcons.chat_bubble_text_fill,
    CupertinoIcons.chart_bar_alt_fill,
    CupertinoIcons.profile_circled,
    CupertinoIcons.book_solid,
    CupertinoIcons.news,
    CupertinoIcons.money_dollar_circle,
  ];

  List<String> iconTittle = [
    'Home',
    'Chat',
    'Attendance',
    'Profile',
    'Library',
    'TechNews',
    'Fees',
  ];

  final screenList = [
    const StudentHomeScreen(),
    const ChatScreen(),
    const StudentAttendanceScreen(),
    const StudentProfileScreen(),
    const GoogleLibraryScreen(),
    const TechNewsScreen(),
    const FeesScreen(),
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    getInfoDetails();
    super.initState();
  }

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
            InfoCard(
              title: "${userInfo['firstName']} ${userInfo['lastName']}",
              imageUrl: userInfo['image'],
              subTitle: "${userInfo['yearValue']} ${userInfo['div']}",
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
