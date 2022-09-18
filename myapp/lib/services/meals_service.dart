import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/models/meal.dart';
import 'package:html/parser.dart' show parse;

class MealsService {
  String hostname = 'http://foodrecommender.rf.gd';
  Future<MealModel> getMeals(String id,String cookieRequest) async {
    var url = Uri.parse('http://foodrecommender.rf.gd/public/api/recommend/$id');
    final response = await http.get(url,headers: {'Cookie': cookieRequest}).timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return MealModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load.');
    }
  }
}
