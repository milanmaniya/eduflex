import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AllSubjectScreen extends StatefulWidget {
  const AllSubjectScreen({super.key});

  @override
  State<AllSubjectScreen> createState() => _AllSubjectScreenState();
}

class _AllSubjectScreenState extends State<AllSubjectScreen> {
  final localStorage = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'All Subject',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(localStorage.read('Field'))
              .snapshots(),
          builder: (context, snapshot) {
            final allSubject = [];

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              for (var element in snapshot.data!.docs) {
                if (element.id == localStorage.read('Semester')) {
                  for (var ele in element['Subject']) {
                    allSubject.add(ele);
                  }
                }
              }
            }

            return ListView.builder(
              itemCount: allSubject.length,
              itemBuilder: (context, index) => Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.network(
                      allSubject[index]['Image'],
                      height: 100,
                      width: 200,
                    ),
                    Text(
                      allSubject[index]['Name'],
                      style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
