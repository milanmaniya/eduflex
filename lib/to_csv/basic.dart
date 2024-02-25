import 'package:flutter/material.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

class BasicScreen extends StatefulWidget {
  const BasicScreen({super.key});

  @override
  State<BasicScreen> createState() => _BasicScreenState();
}

class _BasicScreenState extends State<BasicScreen> {
  void toCsv() {
    List<String> header = [];
    header.add('No.');
    header.add('User Name');
    header.add('Mobile');
    header.add('ID Number');

    List<List<String>> listOfLists = [];
    List<String> data1 = ['1', 'Bilal Saeed', '1374934', '912839812'];
    List<String> data2 = ['2', 'Ahmar', '21341234', '192834821'];

    listOfLists.add(data1);
    listOfLists.add(data2);

    exportCSV.myCSV(
      header,
      listOfLists,
      sharing: true,
      fileName: 'Example.csv',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: toCsv,
          child: const Text('Export Csv Data'),
        ),
      ),
    );
  }
}
