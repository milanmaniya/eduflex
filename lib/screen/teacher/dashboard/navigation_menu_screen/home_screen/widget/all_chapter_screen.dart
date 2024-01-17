import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/home_screen/widget/pdf_viewer_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class AllChapterScreen extends StatefulWidget {
  const AllChapterScreen({super.key});

  @override
  State<AllChapterScreen> createState() => _AllChapterScreenState();
}

class _AllChapterScreenState extends State<AllChapterScreen> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  late String field;
  late String semester;
  late String sub;

  final localStorage = GetStorage();

  @override
  void initState() {
    field = localStorage.read('Field');
    semester = localStorage.read('Semester');
    sub = localStorage.read('Subject');
    log(localStorage.read('Subject').toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'All Chapter',
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => pickFile(),
        child: const Icon(Iconsax.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(field)
            .doc(semester)
            .collection(sub)
            .snapshots(),
        builder: (context, snapshot) {
          List<Map<String, dynamic>>? pdfData = [];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            for (var element in snapshot.data!.docs) {
              if (pdfData!.contains(element.data())) {
                pdfData = null;
              } else {
                pdfData.add(element.data());
              }
            }
          }

          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            itemBuilder: (context, index) => Slidable(
              startActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      log('download the pdf');
                    },
                    autoClose: true,
                    backgroundColor: const Color(0xFF21B7CA),
                    foregroundColor: Colors.white,
                    icon: Icons.download,
                    label: 'Download',
                  ),
                  SlidableAction(
                    autoClose: true,
                    backgroundColor: const Color(0xFFFE4A49),
                    onPressed: (context) {
                      log('delete the pdf');
                    },
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => PdfViewScreen(
                      pdfUrl: pdfData![index]['downloadUrl'].toString(),
                    ),
                  );
                },
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      pdfData![index]['Name'],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            itemCount: pdfData!.length,
          );
        },
      ),
    );
  }

  void downloadPdf() {}

  Future<String> uploadPdf(String fileName, File file) async {
    final reference =
        FirebaseStorage.instance.ref("$field/$semester/$sub/$fileName.pdf");

    final uploadTask = reference.putFile(file);

    await uploadTask.whenComplete(() {});

    final downloadLink = reference.getDownloadURL();

    return downloadLink;
  }

  Future<void> pickFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'],
      type: FileType.custom,
    );

    if (pickedFile != null) {
      String fileName = pickedFile.files[0].name;

      File file = File(pickedFile.files[0].path!);

      log(fileName);

      final downloadLink = await uploadPdf(fileName, file);

      log(downloadLink);

      FirebaseFirestore.instance
          .collection(field)
          .doc(semester)
          .collection(sub)
          .doc(fileName)
          .set({
        'Name': fileName,
        'downloadUrl': downloadLink,
      });

      log('Pdf Upload Successfully');
    }
    setState(() {});
  }
}
