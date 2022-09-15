import "dart:math";
import 'package:flutter/foundation.dart';
import 'package:myapp/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/services.dart';

class MealsRepository {
  final MealsService mealsService;
  MealsRepository({
    required this.mealsService,
  });

  Future<MealModel> fetchMeals() async {
    final prefs = await SharedPreferences.getInstance();
    // print(1);
    try{
      var currentList = prefs.getStringList("favourites") ?? [];
      var randNo;
      var element;
      if (currentList.length > 5){
        final _random = Random();
        randNo = currentList[_random.nextInt(currentList.length)];
        element = randNo.split(';')[0];
      }
      else{
        element = Random().nextInt(320);
      }
      final MealModel meals = await mealsService.getMeals(element.toString());
      List<String>? cList = prefs.getStringList("favourites");
      meals.liked = cList?.contains(meals.id);
      return meals;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
