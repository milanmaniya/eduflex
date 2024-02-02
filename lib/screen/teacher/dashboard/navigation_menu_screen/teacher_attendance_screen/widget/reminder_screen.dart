import 'package:flutter/material.dart';

class RemainderScreen extends StatefulWidget {
  const RemainderScreen({super.key});

  @override
  State<RemainderScreen> createState() => _RemainderScreenState();
}

class _RemainderScreenState extends State<RemainderScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Remainder Screen'),
      ),
    );
  }
}
