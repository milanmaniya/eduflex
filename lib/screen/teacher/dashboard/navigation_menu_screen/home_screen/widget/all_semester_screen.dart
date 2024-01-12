import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        title: const Text(
          'All Subject',
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
                onTap: () {},
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
                    style: Theme.of(context).textTheme.labelMedium!.apply(
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