import 'package:flutter/material.dart';
import 'package:meals_app/data/categoriesContext.dart';
import 'package:provider/provider.dart';

import '../data/mealsContext.dart';
import 'mealsPage.dart';

class CategoryMealsPageArgs {
  final String categoryId;

  const CategoryMealsPageArgs(this.categoryId);
}

class CategoryMealsPage extends StatelessWidget {
  static String get route => "/category-meals";

  const CategoryMealsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CategoryMealsPageArgs;

    final category = context.watch<CategoriesContext>().byId(args.categoryId);
    final meals = context.watch<MealsContext>().byCategory(category.id);

    return MealsPage(
      meals: meals,
      title: category.title,
      color: category.color,
    );
  }
}
