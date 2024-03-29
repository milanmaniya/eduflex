import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/authentication_repository/authentication_repository.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_account_screen/widget/teacher_information_screen.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/teacher_account_screen/widget/update_profile_screen.dart';
import 'package:eduflex/utils/constant/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class TeacherAccountScreen extends StatefulWidget {
  const TeacherAccountScreen({super.key});

  @override
  State<TeacherAccountScreen> createState() => _TeacherAccountScreenState();
}

class _TeacherAccountScreenState extends State<TeacherAccountScreen> {
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
              .collection('Teacher')
              .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                data.addAll(element.data());
                log(data.toString());
              }
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    imageUrl: data['image'],
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      child: Icon(Iconsax.people),
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
                        () => TeacherUpdateProfileScreen(
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
                // const Divider(),
                // const SizedBox(
                //   height: 10,
                // ),

                // // Menu
                // ProfileMenuWidget(
                //   icon: LineAwesomeIcons.cog,
                //   menuName: 'Setting',
                //   onTap: () {},
                // ),
                // ProfileMenuWidget(
                //   icon: LineAwesomeIcons.user_check,
                //   menuName: 'Blocked Student',
                //   onTap: () {},
                // ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                ProfileMenuWidget(
                  icon: LineAwesomeIcons.info,
                  menuName: 'Information',
                  onTap: () => Get.to(
                    () => TeacherInformationScreen(data: data),
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
