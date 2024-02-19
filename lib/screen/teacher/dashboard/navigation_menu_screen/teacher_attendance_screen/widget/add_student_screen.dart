import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '${widget.data['ClassName']} | Today',
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 20),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${widget.data['Sem']} ',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${widget.data['Divison']} ',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Iconsax.search_normal,
              size: 20,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Iconsax.menu,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
