import 'dart:convert';
import 'dart:developer';
import 'package:eduflex/screen/student/tech_news_screens/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GoogleLibraryScreen extends StatefulWidget {
  const GoogleLibraryScreen({super.key});

  static TextEditingController booksController =
      TextEditingController(text: '');

  @override
  State<GoogleLibraryScreen> createState() => _GoogleLibraryScreenState();
}

class _GoogleLibraryScreenState extends State<GoogleLibraryScreen> {
  Future<List> fetchBooks() async {
    final response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/books/v1/volumes?q=${GoogleLibraryScreen.booksController.text}'),
    );

    if (response.statusCode == 200) {
      log(response.body.toString());
      final data = jsonDecode(response.body);

      final result = data['items'];

      return result;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    fetchBooks();
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
          title: const Text('Library'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 15,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        GoogleLibraryScreen.booksController.text = value;

                        setState(() {});
                      },
                      controller: SearchBarScreen.searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search News',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      fetchBooks();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade100,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => fetchBooks(),
                  child: FutureBuilder(
                    future: fetchBooks(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.none &&
                          snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => Text(
                            snapshot.data![index]['volumeInfo']['title'],
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('Books Not Found'),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
