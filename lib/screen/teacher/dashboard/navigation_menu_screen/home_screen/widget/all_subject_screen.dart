import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/home_screen/widget/all_chapter_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';

class AllSubjectScreen extends StatefulWidget {
  const AllSubjectScreen({super.key});

  @override
  State<AllSubjectScreen> createState() => _AllSubjectScreenState();
}

class _AllSubjectScreenState extends State<AllSubjectScreen> {
  final localStorage = GetStorage();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
    ).then((value) {
      setState(() {
        isLoading = true;
      });
    });
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

            return ListView.separated(
              itemCount: allSubject.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  localStorage.write('Subject', allSubject[index]['Name']);
                  Get.to(() => const AllChapterScreen());
                },
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          isLoading
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    allSubject[index]['Image'],
                                    height: 100,
                                    width: 130,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                    ),
                                    height: 110,
                                    width: 110,
                                  ),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            allSubject[index]['Name'],
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!.apply(
                                  color: Colors.black,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            );
          },
        ),
      ),
    );
  }
}
