import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:myapp/models/meal.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'package:dio/dio.dart';

class MealsService {
  String hostname = 'http://foodrecommender.rf.gd';
  Future<MealModel> getMeals(String id) async {
    var dio = Dio();
    var url = Uri.parse('http://foodrecommender.rf.gd/public/api/recommend/$id');
    final response = await http.get(url,headers: {'Cookie': '_test=4e103a726ee8dcc0e004f9bb0beee398; Expires=Wed, 19 Jan 2039 01:14:00 GMT; Domain=foodrecommender.rf.gd; Path=/; HttpOnly	'});
    if (response.statusCode == 200) {
      return MealModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load.');
    }
  }
}
