import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/meal.dart';
import '../../repository/repository.dart';

part 'meals_event.dart';
part 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final MealsRepository _mealsRepository;
  MealsBloc(this._mealsRepository) : super(MealsLoadingState()) {
    on<LoadMealsEvent>(_loadMeals);
  }

  FutureOr<void> _loadMeals(
      LoadMealsEvent event, Emitter<MealsState> emit) async {
    emit(MealsLoadingState());
    try {
      final meals = await _mealsRepository.fetchMeals();
      print(meals);
      emit(MealsLoadedState(meals: meals));
    } catch (e) {
      print(e);
      emit(MealsLoadErrorState(error: e.toString()));
    }
  }
}
