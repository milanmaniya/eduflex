import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({super.key});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllStudent() {
    return FirebaseFirestore.instance.collection('Student').snapshots();
  }

  @override
  void initState() {
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
              const TextField(
                decoration: InputDecoration(labelText: 'Search Student'),
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

                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                      itemCount: data.length,
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
                                  data[index]['image'],
                                ),
                              ),
                            ),
                          ),
                          title: Text(
                            "${data[index]['firstName']} ${data[index]['lastName']}",
                          ),
                          subtitle: Text(
                            "${data[index]['yearValue']} ${data[index]['div']}",
                          ),
                        ),
                      ),
                    );
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
