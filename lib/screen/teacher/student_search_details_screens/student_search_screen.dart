import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StudentSearchScreen extends StatefulWidget {
  const StudentSearchScreen({super.key});

  @override
  State<StudentSearchScreen> createState() => _StudentSearchScreenState();
}

class _StudentSearchScreenState extends State<StudentSearchScreen> {
  TextEditingController txtSearchStudent = TextEditingController();

  List<Map<String, dynamic>> searchData = [];

  List<Map<String, dynamic>> allData = [];

  void searchingData(String value) {
    searchData = allData
        .where((element) =>
            element['userName'].toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  Future<void> allUserData() async {
    final stre = await FirebaseFirestore.instance.collection('Student').get();

    for (var element in stre.docs) {
      allData.add(element.data());
      log(element.data().toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllStudent() {
    return FirebaseFirestore.instance.collection('Student').snapshots();
  }

  @override
  void initState() {
    allUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'All Subject',
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: IconButton(
                icon: const Icon(
                  Iconsax.menu,
                  size: 20,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 13,
            right: 13,
            top: 10,
          ),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  searchData = allData
                      .where(
                        (element) => element['userName'].toLowerCase().contains(
                              value.toLowerCase(),
                            ),
                      )
                      .toList();

                  if (value.isEmpty) {
                    searchData.clear();
                  }

                  setState(() {});
                },
                controller: txtSearchStudent,
                decoration: const InputDecoration(labelText: 'Search Student'),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: getAllStudent(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final data = [];

                    for (var element in snapshot.data!.docs) {
                      data.add(element.data());
                    }

                    if (searchData.isNotEmpty) {
                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                        itemCount: searchData.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            leading: Container(
                              height: 100,
                              width: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    searchData[index]['image'],
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "${searchData[index]['firstName']} ${searchData[index]['lastName']}",
                            ),
                            subtitle: Text(
                              "${searchData[index]['yearValue']} ${searchData[index]['div']}",
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('Search Student'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
