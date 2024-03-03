import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/home_screen/widget/all_semester_screen.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  final localStorage = GetStorage();

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
          children: [
            const Text(
              'All Course',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CommonFieldCard(
              image: 'assets/images/bca.png',
              text: 'BCA',
              desciption: 'Internal English Medium',
              onTap: () {
                localStorage.write('Field', 'BCA');
                Logger().i(localStorage.read('Field'));

                Get.to(() => const AllSemesterScreen());
              },
            ),
            CommonFieldCard(
              image: 'assets/images/bba.png',
              text: 'BBA',
              desciption: 'Internal English Medium',
              onTap: () {
                localStorage.write('Field', 'BBA');
                Logger().i(localStorage.read('Field'));

                Get.to(() => const AllSemesterScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CommonFieldCard extends StatelessWidget {
  const CommonFieldCard(
      {super.key,
      required this.image,
      required this.text,
      required this.desciption,
      required this.onTap});

  final String image;
  final String text;
  final String desciption;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              Image.asset(
                image,
                width: 100,
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    desciption,
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: Colors.black87,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
