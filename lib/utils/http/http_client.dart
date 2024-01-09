import 'dart:convert';
import 'dart:developer';
import 'package:eduflex/utils/logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:eduflex/utils/helper/helper_function.dart';

class THttpHelper {
  static Future<List> httpGet(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final data = json[''] as List;
      return data; 
    } else {
      THelperFunction.showSnackBar(response.statusCode.toString());
      return [];  
    }
  }

  static Future<void> httpPost(String url, Map<String, dynamic> data) async {
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 201) {
      TLoggerHelper().info(response.body);
      TLoggerHelper().debug(response.statusCode.toString());
    } else {
      THelperFunction.showSnackBar(response.statusCode.toString());
    }
  }

  static Future<void> httpDelete(String url) async {
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      log(response.statusCode.toString());
      log(response.body);
    } else {
      THelperFunction.showSnackBar(response.statusCode.toString());
    }
  }

  static Future<void> httpPut(String url, Map<String, dynamic> data) async {
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      log(response.statusCode.toString());
      log(response.body);
    } else {
      THelperFunction.showSnackBar(response.statusCode.toString());
    }
  }
}
