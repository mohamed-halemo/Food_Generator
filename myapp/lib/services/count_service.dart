import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/models/meal.dart';
import 'package:html/parser.dart' show parse;

class CountService {
  Future<List> getCount() async {
    var url = Uri.parse('http://foodrecommender.rf.gd/public/api/recommender/len');
    final cookie = await http.get(url).timeout(const Duration(seconds: 20));
    var document = parse(cookie.body);
    List<String> cookieValue = document.getElementsByTagName('script')[0].innerHtml.split(';');
    // print(cookieValue);
    String cookieRequest = cookieValue[0].substring(17);
    final response = await http.get(url,headers: {'Cookie': cookieRequest}).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return [response.body,cookieRequest];
    } else {
      throw Exception('Failed to load.');
    }
  }
}