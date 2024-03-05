import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleLibraryScreen extends StatefulWidget {
  const GoogleLibraryScreen({super.key});

  @override
  State<GoogleLibraryScreen> createState() => _GoogleLibraryScreenState();
}

class _GoogleLibraryScreenState extends State<GoogleLibraryScreen> {
  Future<void> fetchBooks() async {
    final response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=java'));

    if (response.statusCode == 200) {
      log(response.body.toString());
    }
  }

  @override
  void initState() {
    fetchBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Google Library Screen'),
      ),
    );
  }
}
