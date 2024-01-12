import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/home_screen/widget/all_subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AllSemesterScreen extends StatefulWidget {
  const AllSemesterScreen({super.key});

  @override
  State<AllSemesterScreen> createState() => _AllSemesterScreenState();
}

class _AllSemesterScreenState extends State<AllSemesterScreen> {
  final localStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'All Semester',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(localStorage.read('Field'))
            .snapshots(),
        builder: (context, snapshot) {
          final allSemList = [];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            for (var element in snapshot.data!.docs) {
              allSemList.add(element.id);
            }
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  final localStorage = GetStorage();

                  localStorage.write('Semester', allSemList[index]);

                  Get.to(() => const AllSubjectScreen());
                },
                child: Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    allSemList[index],
                    style: Theme.of(context).textTheme.bodyLarge!.apply(
                          color: Colors.black,
                        ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
