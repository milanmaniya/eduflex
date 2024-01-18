import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_account_screen/widget/student_information_screen.dart';
import 'package:eduflex/screen/student/dashboard/navigation_menu_sreen/student_account_screen/widget/student_update_profile_screen.dart';
import 'package:eduflex/utils/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(localStorage.read('Screen'))
              .snapshots(),
          builder: (context, snapshot) {
            Map<String, dynamic> data = {};

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              for (var element in snapshot.data!.docs) {
                if (element.id == FirebaseAuth.instance.currentUser!.uid) {
                  data.addAll(element.data());
                  log(data.toString());
                }
              }
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: NetworkImage(data['image']),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  data['userName'],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  data['email'],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(
                        () => StudentUpdateProfile(
                          data: data,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Edit Profile'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),

                // Menu
                ProfileMenuWidget(
                  icon: LineAwesomeIcons.cog,
                  menuName: 'Setting',
                  onTap: () {},
                ),
                ProfileMenuWidget(
                  icon: LineAwesomeIcons.user_check,
                  menuName: 'Blocked Student',
                  onTap: () {},
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                ProfileMenuWidget(
                  icon: LineAwesomeIcons.info,
                  menuName: 'Information',
                  onTap: () => Get.to(
                    () => StudentInformationScreen(data: data),
                  ),
                ),
                ProfileMenuWidget(
                  icon: LineAwesomeIcons.alternate_sign_out,
                  menuName: 'Logout',
                  endIcon: false,
                  textColor: Colors.red,
                  onTap: () {
                    AuthenticationReposotiry.instance.logout();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.menuName,
    required this.icon,
    required this.onTap,
    this.textColor,
    this.endIcon = true,
  });

  final String menuName;
  final IconData icon;
  final VoidCallback onTap;
  final Color? textColor;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: TColor.primary.withOpacity(0.1),
        ),
        child: Icon(
          icon,
          color: TColor.primary,
        ),
      ),
      title: Text(
        menuName,
        style: Theme.of(context).textTheme.bodyLarge!.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                color: Colors.grey,
                size: 18,
              ),
            )
          : null,
    );
  }
}
