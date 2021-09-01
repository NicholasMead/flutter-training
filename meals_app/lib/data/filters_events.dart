import 'package:equatable/equatable.dart';

abstract class FiltersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetFilterEvent extends FiltersEvent {
  final bool? showGlutenFree;
  final bool? showLactoseFree;
  final bool? showVegan;

  SetFilterEvent({
    this.showGlutenFree,
    this.showLactoseFree,
    this.showVegan,
  });

  @override
  List<Object?> get props => [showGlutenFree, showLactoseFree, showVegan];
}

class ClearFiltersEvent extends FiltersEvent {}
