import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class BasicScreen extends StatefulWidget {
  const BasicScreen({super.key});

  @override
  State<BasicScreen> createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen> {
  Future<void> createExcel() async {
    final Workbook workbook = Workbook();

    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').setText('Milan');
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;

    final String fileName = '$path/Example.xlsx';

    final File file = File(fileName);

    await file.writeAsBytes(bytes);

    OpenFilex.open(fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: createExcel,
              child: const Text('Export Csv Data'),
            ),
          ),
        ),
      ),
    );
  }
}
