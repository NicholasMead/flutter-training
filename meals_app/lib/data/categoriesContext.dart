import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';

class CategoriesContext with ChangeNotifier {
  final List<Category> _categories;

  CategoriesContext() : _categories = getDummyData();

  List<Category> get all => _categories.toList(growable: false);

  Category byId(String id) => _categories.firstWhere((c) => c.id == id);

  static ChangeNotifierProvider<CategoriesContext> asProvider(
          {Widget? child}) =>
      ChangeNotifierProvider<CategoriesContext>(
        create: (_) => CategoriesContext(),
        child: child,
      );
}

List<Category> getDummyData() => [
      Category(
        id: 'c1',
        title: 'Italian',
        color: Colors.purple,
      ),
      Category(
        id: 'c2',
        title: 'Quick & Easy',
        color: Colors.red,
      ),
      Category(
        id: 'c3',
        title: 'Hamburgers',
        color: Colors.orange,
      ),
      Category(
        id: 'c4',
        title: 'German',
        color: Colors.amber,
      ),
      Category(
        id: 'c5',
        title: 'Light & Lovely',
        color: Colors.blue,
      ),
      Category(
        id: 'c6',
        title: 'Exotic',
        color: Colors.green,
      ),
      Category(
        id: 'c7',
        title: 'Breakfast',
        color: Colors.lightBlue,
      ),
      Category(
        id: 'c8',
        title: 'Asian',
        color: Colors.lightGreen,
      ),
      Category(
        id: 'c9',
        title: 'French',
        color: Colors.pink,
      ),
      Category(
        id: 'c10',
        title: 'Summer',
        color: Colors.teal,
      ),
    ];
