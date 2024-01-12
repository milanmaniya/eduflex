import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'All Course',
          style: Theme.of(context).textTheme.labelLarge!.apply(
                color: Colors.black,
              ),
        ),
      ),
      body: Column(
        children: [
          CommonFieldCard(
            image: 'assets/images/bca.png',
            text: 'BCA',
            desciption: 'Internal English Medium',
            onTap: () {
              localStorage.write('Field', 'BCA');
              Logger().i(localStorage.read('Field'));
            },
          ),
          CommonFieldCard(
            image: 'assets/images/bba.png',
            text: 'BBA',
            desciption: 'Internal English Medium',
            onTap: () {
              localStorage.write('Field', 'BCA');
              Logger().i(localStorage.read('Field'));
            },
          ),
        ],
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
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                        color: Colors.black,
                      ),
                ),
                Text(
                  desciption,
                  style: Theme.of(context).textTheme.labelSmall!.apply(
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
