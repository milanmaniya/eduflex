import 'dart:convert';
import 'dart:developer';
import 'package:eduflex/screen/student/tech_news_screens/widget/search_bar.dart';
import 'package:http/http.dart' as http;

const apiKey = 'f103ba3f3d7240a09ccb4cd6fd10c8f4';

Future<List> fetchNews() async {
  final response = await http.get(
    Uri.parse(
      'https://newsapi.org/v2/top-headlines?country=us&category=technology&pageSize=100&apiKey=$apiKey&q=${SearchBarScreen.searchController.text}',
    ),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map;

    final result = data['articles'] as List;
    log(result.toString());

    return result;
  } else {
    return [];
  }
}
