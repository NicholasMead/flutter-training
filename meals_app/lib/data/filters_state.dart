import 'package:equatable/equatable.dart';
import 'package:meals_app/models/meal.dart';

class FiltersState extends Equatable {
  final bool showGlutenFree;
  final bool showLactoseFree;
  final bool showVegan;

  FiltersState({
    required this.showGlutenFree,
    required this.showLactoseFree,
    required this.showVegan,
  });

  FiltersState.initial()
      : showGlutenFree = false,
        showLactoseFree = false,
        showVegan = false;

  bool get showAll => !showGlutenFree && !showLactoseFree && !showVegan;

  @override
  List<Object?> get props => [showGlutenFree, showLactoseFree, showVegan];
}

extension FiltersMealListExtension on Iterable<Meal> {
  Iterable<Meal> withFilters(FiltersState filters) {
    return this
        .where((meal) => !filters.showGlutenFree || meal.isGlutenFree)
        .where((meal) => !filters.showLactoseFree || meal.isLactoseFree)
        .where((meal) => !filters.showVegan || meal.isVegan);
  }
}
