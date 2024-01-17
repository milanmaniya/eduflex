import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:logger/logger.dart';

class AllChapterScreen extends StatefulWidget {
  const AllChapterScreen({super.key});

  @override
  State<AllChapterScreen> createState() => _AllChapterScreenState();
}

class _AllChapterScreenState extends State<AllChapterScreen> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  final localStorage = GetStorage();

  @override
  void initState() {
    log(localStorage.read('Subject').toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filename = pickedFile!.name;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'All Chapter',
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              height: 250,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selectFile,
                      child: const Text('Select File'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    pickedFile != null ? filename : 'No File Selected',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: uploadFile,
                      child: const Text('Upload File'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildProgress(uploadTask!),
                ],
              ),
            ),
          );
        },
        child: const Icon(Iconsax.add),
      ),
      body: const Center(
        child: Text('All Chapter Screen'),
      ),
    );
  }

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: [
        'pdf',
      ],
    );

    if (result == null) {
      return;
    }

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future<void> uploadFile() async {
    final localStorage = GetStorage();

    final path =
        "${localStorage.read('Field')}/${localStorage.read('Semester')}/${localStorage.read('Subject')}/$pickedFile.name.pdf";

    Logger().i(path.toString());

    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref(path);

    uploadTask = ref.putFile(file);
    setState(() {});

    if (uploadTask == null) {
      return;
    }

    final snapShot = await uploadTask!.whenComplete(() {});

    final downloadUrl = await snapShot.ref.getDownloadURL();
    Logger().i('Download Url :$downloadUrl');
  }

  Widget buildProgress(UploadTask task) {
    return StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          final progress = data.bytesTransferred / data.totalBytes;

          final percentage = (progress * 100).toStringAsFixed(2);

          return Text(
            // '${(100 * ${progress}).roundToDouble()}%',
            '$percentage %',
            style: Theme.of(context).textTheme.bodyLarge!.apply(
                  color: Colors.white,
                ),
          );

          // return SizedBox(
          //   height: 30,
          //   child: Stack(
          //     fit: StackFit.expand,
          //     children: [
          //       LinearProgressIndicator(
          //         value: progress,
          //         backgroundColor: Colors.grey,
          //         color: Colors.green,
          //       ),
          //       Center(
          //         child: Text(
          //           '${(100 * progress).roundToDouble()}%',
          //           style: Theme.of(context).textTheme.bodyLarge!.apply(
          //                 color: Colors.white,
          //               ),
          //         ),
          //       ),
          //     ],
          //   ),
          // );
        } else {
          return const SizedBox(
            height: 50,
          );
        }
      },
    );
  }
}
