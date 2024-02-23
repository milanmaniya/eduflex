import 'dart:developer';

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

  Stream<QuerySnapshot<Map<String, dynamic>>> getallSubjectAttendance(
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
      body: StreamBuilder(
        // stream: getallSubjectAttendance('TYBCA-SEM6', 'Divison-3'),
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
              log(element.id.toString());

              log(element.data().toString());

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
                    log(element.id.toString());
                    log(element.data().toString());

                    classData.add(element.data());
                  }
                }

                return const Center(
                  child: Text('Hello World'),
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
