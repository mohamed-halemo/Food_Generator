part of 'meals_bloc.dart';

abstract class MealsState extends Equatable {
  const MealsState();

  @override
  List<Object> get props => [];
}

class MealsLoadingState extends MealsState {}

class MealsLoadedState extends MealsState {
  final MealModel meals;

  const MealsLoadedState({required this.meals});

  @override
  List<Object> get props => [meals];

  @override
  String toString() => 'MealsLoadedState { meals: $meals }';

  MealsLoadedState copyWith({
    MealModel? meals,
  }) {
    return MealsLoadedState(
      meals: meals ?? this.meals,
    );
  }
}

class MealsLoadErrorState extends MealsState {
  final String error;

  const MealsLoadErrorState({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MealsLoadErrorState { error: $error }';
}
