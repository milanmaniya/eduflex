import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduflex/screen/student/tech_news_screens/api/technews_api.dart';
import 'package:eduflex/screen/student/tech_news_screens/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TechNewsScreen extends StatefulWidget {
  const TechNewsScreen({super.key});

  @override
  State<TechNewsScreen> createState() => _TechNewsScreenState();
}

class _TechNewsScreenState extends State<TechNewsScreen> {
  TextEditingController txtSeach = TextEditingController();

  late Future<List> news;

  Future<void> urlLauncher(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {}
  }

  final imageForError =
      'https://th.bing.com/th/id/OIG3.WYeItAo3B5DR2Hhcpxl8?w=1024&h=1024&rs=1&pid=ImgDetMain';

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
                            urlLauncher(snapshot.data![index]['url']);
                            // showMyBottomSheet(
                            //   context: context,
                            //   titie: snapshot.data![index]['title'],
                            //   description: snapshot.data![index]['description'],
                            //   imageUrl: snapshot.data![index]['urlToImage'] ??
                            //       imageForError,
                            //   url: snapshot.data![index]['url'],
                            // );
                          },
                          leading: CachedNetworkImage(
                            imageUrl: snapshot.data![index]['urlToImage'] ??
                                imageForError,
                            height: 80,
                            width: 80,
                            errorWidget: (context, url, error) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          title: Text(
                            snapshot.data![index]['title'],
                            maxLines: 2,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            )
                          ),
                          subtitle: Text(snapshot.data![index]['publishedAt']),
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
            ],
          ),
        ),
      ),
    );
  }
}

//   PersistentBottomSheetController<dynamic> showMyBottomSheet({
//     required BuildContext context,
//     required titie,
//     required description,
//     required imageUrl,
//     required url,
//   }) {
//     return showBottomSheet(
//       backgroundColor: Colors.black,
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       elevation: 20,
//       builder: (context) => MyBottomSheetLayout(
//         title: titie,
//         description: description,
//         imageUrl: imageUrl,
//         url: url,
//       ),
//     );
//   }
// }



// class MyBottomSheetLayout extends StatelessWidget {
//   const MyBottomSheetLayout({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     required this.url,
//   });

//   final String title;
//   final String description;
//   final String imageUrl;
//   final String url;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         BottomSheetImage(
//           imageUrl: imageUrl,
//           title: title,
//         ),

//         // decription
//         Container(
//           padding: const EdgeInsets.all(10),
//           child: ModifiedText(
//             text: description,
//             size: 16,
//             color: Colors.white,
//           ),
//         ),

//         Padding(
//           padding: const EdgeInsets.all(10),
//           child: TextButton(
//             onPressed: () {
//               // urlLauncher(url);
//             },
//             child: const Text('Read Full Article'),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class BottomSheetImage extends StatelessWidget {
//   const BottomSheetImage({
//     super.key,
//     required this.imageUrl,
//     required this.title,
//   });

//   final String imageUrl;
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 300,
//       child: Stack(
//         children: [
//           Container(
//             foregroundDecoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.black,
//                   Colors.transparent,
//                 ],
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//               ),
//             ),
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//               image: DecorationImage(
//                 fit: BoxFit.cover,
//                 image: NetworkImage(
//                   imageUrl,
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             child: Container(
//               width: 300,
//               padding: const EdgeInsets.all(10),
//               child: ModifiedBoldText(
//                 text: title,
//                 size: 18,
//                 color: Colors.white,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
