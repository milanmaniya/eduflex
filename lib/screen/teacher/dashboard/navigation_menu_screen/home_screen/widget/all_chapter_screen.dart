import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/screen/teacher/dashboard/navigation_menu_screen/home_screen/widget/pdf_viewer_screen.dart';
import 'package:eduflex/utils/popups/loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
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
  double _progress = 0.0;

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
      floatingActionButton: localStorage.read('Screen') == 'Teacher'
          ? FloatingActionButton(
              onPressed: () => pickFile(),
              child: const Icon(Iconsax.add),
            )
          : null,
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
                  localStorage.read('Screen') == 'Student'
                      ? SlidableAction(
                          onPressed: (context) {
                            downloadPdf(
                                pdfData![index]['downloadUrl'].toString());
                          },
                          autoClose: true,
                          backgroundColor: const Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.download,
                          label: 'Download',
                        )
                      : const SizedBox(),
                  localStorage.read('Screen') == ' Teacher'
                      ? SlidableAction(
                          autoClose: true,
                          backgroundColor: const Color(0xFFFE4A49),
                          onPressed: (context) => deletePdf(
                            pdfData![index]['downloadUrl'].toString(),
                            pdfData[index]['Name'].toString(),
                          ),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        )
                      : const SizedBox(),
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

  void deletePdf(String url, String filename) {
    FirebaseFirestore.instance
        .collection(field)
        .doc(semester)
        .collection(sub)
        .doc(filename)
        .delete()
        .whenComplete(() {
      TLoader.successSnackBar(
        title: 'Successfully',
        message: 'Pdf Deleted Successfully',
      );
    });

    final storage = FirebaseStorage.instance.refFromURL(url);

    storage.delete();
    log('file deleted successfully');
    setState(() {});
  }

  void downloadPdf(String downloadUrl) {
    FileDownloader.downloadFile(
      onDownloadError: (errorMessage) =>
          TLoader.errorSnackBar(title: errorMessage.toString()),
      onDownloadCompleted: (path) {
        TLoader.successSnackBar(title: 'File Download Successfully');
      },
      onProgress: (fileName, progress) {
        setState(() {
          _progress = progress;
          log(_progress.toString());
        });
      },
      url: downloadUrl,
    );
    setState(() {});
  }

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

      TLoader.successSnackBar(
          title: 'Succesfully', message: 'File Uploaded Successfully');
    }
    setState(() {});
  }
}
