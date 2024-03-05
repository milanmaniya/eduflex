import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduflex/screen/student/tech_news_screens/api/technews_api.dart';
import 'package:eduflex/screen/student/tech_news_screens/widget/search_bar.dart';
import 'package:eduflex/screen/student/tech_news_screens/widget/web_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TechNewsScreen extends StatefulWidget {
  const TechNewsScreen({super.key});

  @override
  State<TechNewsScreen> createState() => _TechNewsScreenState();
}

class _TechNewsScreenState extends State<TechNewsScreen> {
  TextEditingController txtSeach = TextEditingController();

  late Future<List> news;

  final imageForError =
      'https://th.bing.com/th/id/OIG3.WYeItAo3B5DR2Hhcpxl8?w=1024&h=1024&rs=1&pid=ImgDetMain';

  late final WebViewController controller;

  @override
  void initState() {
    news = fetchNews();

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
          title: const Text('Tech News'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 15,
          ),
          child: Column(
            children: [
              const SearchBarScreen(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: fetchNews,
                  child: FutureBuilder(
                    future: fetchNews(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.none &&
                          snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        return ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.black26,
                            height: 20,
                          ),
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) => ListTile(
                            onTap: () {
                              controller = WebViewController()
                                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                ..setBackgroundColor(const Color(0x00000000))
                                ..setNavigationDelegate(
                                  NavigationDelegate(
                                    onNavigationRequest:
                                        (NavigationRequest request) {
                                      if (request.url.startsWith(
                                          'https://www.youtube.com/')) {
                                        return NavigationDecision.prevent;
                                      }
                                      return NavigationDecision.navigate;
                                    },
                                  ),
                                )
                                ..loadRequest(
                                  Uri.parse(
                                      'https://pub.dev/packages/webview_flutter'),
                                ).then((value) {
                                  Get.to(
                                    () =>
                                        WebViewSecreen(controller: controller),
                                  );
                                });
                            },
                            leading: CachedNetworkImage(
                              imageUrl: snapshot.data![index]['urlToImage'] ??
                                  imageForError,
                              height: 80,
                              width: 80,
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            title: Text(snapshot.data![index]['title'],
                                maxLines: 2,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                )),
                            subtitle:
                                Text(snapshot.data![index]['publishedAt']),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text('News Not Found'),
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
