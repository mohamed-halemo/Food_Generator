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
      var element;
      if (currentList.length != 0){
        final _random = Random();
        element = currentList[_random.nextInt(currentList.length)];
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
