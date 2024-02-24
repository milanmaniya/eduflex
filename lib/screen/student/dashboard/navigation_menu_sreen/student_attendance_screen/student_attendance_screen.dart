import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  final localStorage = GetStorage();

  Stream<QuerySnapshot<Map<String, dynamic>>> getallClass(
      String sem, String divison) {
    return FirebaseFirestore.instance
        .collection('Attendance')
        .where('Sem', isEqualTo: sem)
        .where('Divison', isEqualTo: divison)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentUserData() {
    return FirebaseFirestore.instance
        .collection('Student')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Attendance',
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: getCurrentUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final currentUserData = [];

          if (snapshot.hasData) {
            for (var element in snapshot.data!.docs) {
              // log(element.id.toString());

              // log(element.data().toString());

              currentUserData.add(element.data());
            }
          }

          if (currentUserData.isNotEmpty) {
            return StreamBuilder(
              stream: getallClass(
                  currentUserData[0]['yearValue'], currentUserData[0]['div']),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final classData = [];

                if (snapshot.hasData) {
                  for (var element in snapshot.data!.docs) {
                    // log(element.id.toString());
                    // log(element.data().toString());

                    classData.add(element.data());
                  }
                }

                // if (classData.isNotEmpty) {
                //   return Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: ListView.separated(
                //       itemBuilder: (context, index) {
                //         return InkWell(
                //           onTap: () {
                //             Get.to(
                //               () => StudentAbsentPresentScreen(
                //                 className: classData[index]['ClassName'],
                //                 classId: classData[index]['ClassId'],
                //               ),
                //             );
                //           },
                //           child: Card(
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(12),
                //             ),
                //             child: ListTile(
                //               contentPadding: const EdgeInsets.symmetric(
                //                 vertical: 10,
                //                 horizontal: 10,
                //               ),
                //               title: Text(
                //                 classData[index]['ClassName'],
                //                 style: const TextStyle(
                //                   height: 2,
                //                   fontSize: 15,
                //                 ),
                //               ),
                //               subtitle: Row(
                //                 children: [
                //                   Text(
                //                     classData[index]['Sem'],
                //                     style: const TextStyle(
                //                       fontSize: 12,
                //                     ),
                //                   ),
                //                   const SizedBox(
                //                     width: 8,
                //                   ),
                //                   Text(
                //                     classData[index]['Divison'],
                //                     style: const TextStyle(
                //                       fontSize: 12,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         );
                //       },
                //       separatorBuilder: (context, index) => const SizedBox(
                //         height: 2,
                //       ),
                //       itemCount: classData.length,
                //     ),
                //   );
                // } else {
                //   return const Center(
                //     child: Text('Class Not Found'),
                //   );
                // }

                return const Center(
                  child: Text('Class Not Found'),
                );
              },
            );
          } else {
            return const Center(
              child: Text('User Not Found'),
            );
          }
        },
      ),
    );
  }
}
