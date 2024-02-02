import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_attendance_screen/widget/classes_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_attendance_screen/widget/notes_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_attendance_screen/widget/reminder_screen.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: TSize.appBarHeight,
          left: 10,
          right: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              height: 50,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                controller: tabController,
                indicator: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                tabs: const [
                  Tab(
                    text: 'Class',
                  ),
                  Tab(
                    text: 'Notes',
                  ),
                  Tab(
                    text: 'Remainder',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  ClassesScreen(),
                  NotesScreen(),
                  RemainderScreen()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
