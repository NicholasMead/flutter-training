import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';

// class FiltersContext with ChangeNotifier {
//   bool _showVegan = false;
//   bool _showLactoseFree = false;
//   bool _showGluttenFree = false;

//   bool get showAll => !_showVegan && !_showGluttenFree && !_showLactoseFree;
//   void setShowAll() {
//     if (showAll) return;

//     _showVegan = false;
//     _showLactoseFree = false;
//     _showGluttenFree = false;

//     notifyListeners();
//   }

//   bool get showVegan => _showVegan;
//   set showVegan(bool value) {
//     if (_showVegan == value) return;

//     _showVegan = value;
//     notifyListeners();
//   }

//   bool get showLactoseFree => _showLactoseFree;
//   set showLactoseFree(bool value) {
//     if (_showLactoseFree == value) return;

//     _showLactoseFree = value;
//     notifyListeners();
//   }

//   bool get showGluttenFree => _showGluttenFree;
//   set showGluttenFree(bool value) {
//     if (_showGluttenFree == value) return;

//     _showGluttenFree = value;
//     notifyListeners();
//   }

//   Iterable<Meal> filter(Iterable<Meal> meals) sync* {
//     for (var meal in meals) {
//       var show = (!_showVegan || meal.isVegan) &&
//           (!_showGluttenFree || meal.isGlutenFree) &&
//           (!_showLactoseFree || meal.isLactoseFree);

//       if (showAll || show) yield meal;
//     }
//   }

//   static ChangeNotifierProvider asProvider({Widget? child}) =>
//       ChangeNotifierProvider<FiltersContext>(
//         create: (_) => FiltersContext(),
//         child: child,
//       );
// }
