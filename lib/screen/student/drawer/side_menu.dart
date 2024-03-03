import 'package:eduflex/common/widget/info_card.dart';
import 'package:eduflex/common/widget/side_menu_card.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideMenuScreen extends StatefulWidget {
  const SideMenuScreen({super.key});

  @override
  State<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  List<IconData> iconDataList = [
    CupertinoIcons.home,
    CupertinoIcons.chat_bubble_text_fill,
    CupertinoIcons.chart_bar_alt_fill,
    CupertinoIcons.profile_circled,
    CupertinoIcons.book_solid,
    CupertinoIcons.news,
  ];

  List<String> iconTittle = [
    'Home',
    'Chat',
    'Attendance',
    'Profile',
    'Library',
    'TechNews'
  ];

  // final screenList = [
  //   const StudentHomeScreen(),
  //   const ChatScreen(),
  //   const StudentAttendanceScreen(),
  //   const StudentProfileScreen(),
  //   const StudentHomeScreen(),
  //   const ChatScreen(),
  // ];

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
                  // Get.offAll(() => screenList[selectedIndex]);
                  setState(() {});
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
