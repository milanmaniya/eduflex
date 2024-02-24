import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentAbsentPresentScreen extends StatefulWidget {
  const StudentAbsentPresentScreen(
      {super.key, required this.className, required this.classId});

  final String className;
  final String classId;
  @override
  State<StudentAbsentPresentScreen> createState() =>
      _StudentAbsentPresentScreenState();
}

class _StudentAbsentPresentScreenState
    extends State<StudentAbsentPresentScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>> getallSubjectAttendance({
    required String classId,
    required String className,
  }) {
    return FirebaseFirestore.instance
        .collection('Attendance')
        .doc(classId)
        .collection('Student')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(className)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    int totalNumberOfLeacture = 0;
    int totalNumberOfPresent = 0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.className,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: getallSubjectAttendance(
            classId: widget.classId, className: widget.className),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final date = [];

          final attendanceValue = [];

          if (snapshot.hasData) {
            for (var element in snapshot.data!.docs) {
              log(element.id.toString());
              log(element.data().toString());

              date.add(element.id);
              attendanceValue.add(element.data());
            }
          }

          totalNumberOfLeacture = date.length;

          log('Total number of leacture: $totalNumberOfLeacture');

          for (var i = 0; i < totalNumberOfLeacture; i++) {
            if (attendanceValue[i]['Value'] == true) {
              totalNumberOfPresent = totalNumberOfPresent + 1;
            }
          }
          log('Total number of present: $totalNumberOfPresent');

          final attendance = totalNumberOfPresent / totalNumberOfLeacture * 100;

          if (attendanceValue.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          title: Text(
                            widget.className,
                            style: const TextStyle(
                              height: 2,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            date[index],
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          trailing: Container(
                            height: 40,
                            width: 60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: attendanceValue[index]['Value'] == true
                                  ? Colors.green.shade400
                                  : Colors.red.shade400,
                            ),
                            child: attendanceValue[index]['Value'] == true
                                ? const Text(
                                    'Present',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const Text(
                                    'Absent',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 2,
                      ),
                      itemCount: attendanceValue.length,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Total Number of Leacture : $totalNumberOfLeacture'),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Total Number of Present : $totalNumberOfPresent'),
                        Text('Attendance : $attendance')
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Student Absent Present Screen'),
            );
          }
        },
      ),
    );
  }
}
