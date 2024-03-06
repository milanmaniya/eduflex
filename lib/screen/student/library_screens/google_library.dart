import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduflex/screen/student/tech_news_screens/widget/search_bar.dart';
import 'package:eduflex/screen/student/tech_news_screens/widget/technews_web_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

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
            horizontal: 10,
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
                        return ListView.separated(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => Divider(
                            height: 22,
                            thickness: 1,
                            color: Colors.grey.shade300,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) =>
                              SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: InkWell(
                              onTap: () {
                                late final WebViewController controller;

                                controller = WebViewController()
                                  ..setJavaScriptMode(
                                      JavaScriptMode.unrestricted)
                                  ..setBackgroundColor(const Color(0x00000000))
                                  ..setNavigationDelegate(
                                    NavigationDelegate(
                                      onNavigationRequest:
                                          (NavigationRequest request) {
                                        return NavigationDecision.prevent;
                                      },
                                    ),
                                  )
                                  ..loadRequest(
                                    //   Uri.parse(
                                    //   'https://books.google.co.in/books?id=HpX4CwAAQBAJ&printsec=frontcover&dq=php&hl=en&cd=10&source=gbs_api#v=onepage&q=php&f=false',
                                    // )
                                    Uri.parse(
                                      snapshot.data![index]['volumeInfo']
                                          ['previewLink'],
                                    ),
                                  ).then((value) {
                                    Get.to(
                                      () => WebViewSecreen(
                                        controller: controller,
                                      ),
                                    );
                                  });
                                setState(() {});
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      imageUrl: snapshot.data![index]
                                                  ['volumeInfo']['imageLinks']
                                              ['thumbnail'] ??
                                          '',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapshot.data![index]['volumeInfo']
                                                ['title'] ??
                                            '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        snapshot.data![index]['volumeInfo']
                                                ['publisher'] ??
                                            '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const Spacer(),
                                  // Text(
                                  //   snapshot.data![index]['volumeInfo']
                                  //           ['publishedDate'] ??
                                  //       '',
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('Books Not Found'),
                        );
                      }

                      // if (snapshot.hasData) {
                      //   return ListView.builder(
                      //     physics: const BouncingScrollPhysics(),
                      //     itemCount: snapshot.data!.length,
                      //     itemBuilder: (context, index) => ListTile(
                      //       title: Text(
                      //         snapshot.data![index]['volumeInfo']['title'],
                      //         maxLines: 1,
                      //         style: const TextStyle(
                      //           overflow: TextOverflow.ellipsis,
                      //         ),
                      //       ),
                      //       leading: CachedNetworkImage(
                      //         imageUrl: snapshot.data![index]['volumeInfo']
                      //                 ['imageLinks']['thumbnail'] ??
                      //             '',
                      //         width: 80,
                      //         fit: BoxFit.cover,
                      //         errorWidget: (context, url, error) =>
                      //             const Center(
                      //           child: CircularProgressIndicator(),
                      //         ),
                      //       ),
                      //       trailing: Text(
                      //         snapshot.data![index]['volumeInfo']
                      //                 ['publishedDate'] ??
                      //             '',
                      //       ),
                      //       subtitle: Text(
                      //         snapshot.data![index]['volumeInfo']
                      //                 ['publisher'] ??
                      //             '',
                      //         maxLines: 1,
                      //         style: const TextStyle(
                      //           overflow: TextOverflow.ellipsis,
                      //         ),
                      //       ),
                      //     ),
                      //   );
                      // } else {
                      //   return const Center(
                      //     child: Text('Books Not Found'),
                      //   );
                      // }
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
