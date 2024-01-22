import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduflex/common/widget/chat_screen/widget/chat_user_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatSearchScreen extends StatefulWidget {
  const ChatSearchScreen({super.key});

  @override
  State<ChatSearchScreen> createState() => _ChatSearchScreenState();
}

class _ChatSearchScreenState extends State<ChatSearchScreen> {
  List<Map<String, dynamic>> searchData = [];

  List<Map<String, dynamic>> allData = [];

  final TextEditingController txtSearch = TextEditingController();

  @override
  void initState() {
    allUserData();
    super.initState();
  }

  void searchingData(String value) {
    searchData = allData
        .where((element) =>
            element['userName'].toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  Future<void> allUserData() async {
    final stre = await FirebaseFirestore.instance.collection('Student').get();

    for (var element in stre.docs) {
      allData.add(element.data());
    }

    final str = await FirebaseFirestore.instance.collection('Teacher').get();

    for (var element in str.docs) {
      allData.add(element.data());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
          controller: txtSearch,
          onChanged: (value) => searchingData(value),
          decoration: const InputDecoration(
            hintText: 'Search Here',
            prefixIcon: Icon(Iconsax.search_normal),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: ListView.separated(
          itemBuilder: (context, index) {
            if (searchData.isNotEmpty) {
              return ChatUserCard(
                title: searchData[index]['userName'],
                subTitle: searchData[index]['about'],
                image: searchData[index]['image'],
              );
            } else {
              return const Center(
                child: Text('No Data Found!'),
              );
            }
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 5,
          ),
          itemCount: searchData.length,
        ),
      ),
    );
  }
}
