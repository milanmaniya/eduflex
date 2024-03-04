import 'package:flutter/material.dart';

class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({super.key});

  static TextEditingController searchController =
      TextEditingController(text: '');

  @override
  State<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
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
            // fetchNews();
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
    );
  }
}
