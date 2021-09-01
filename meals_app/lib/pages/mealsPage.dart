import 'package:flutter/material.dart';
import 'package:meals_app/widgets/filterAppBarAction.dart';
import 'package:provider/provider.dart';

import '../data/mealsContext.dart';
import '../data/filters_bloc.dart';
import '../widgets/mealTile.dart';
import '../models/meal.dart';
import './mealDetailPage.dart';

class MealsPage extends StatelessWidget {
  final String title;
  final Color? color;
  final List<Meal> meals;

  void navigateToMeal(BuildContext ctx, Meal meal) {
    Navigator.of(ctx).pushNamed(
      MealDetailPage.route,
      arguments: MealDetailPageArgs(meal: meal),
    );
  }

  MealsPage({
    required this.title,
    required this.meals,
    this.color,
  });

  MealsPage.all(BuildContext ctx)
      : this(
          title: "Nick's Bistro",
          meals: ctx.watch<MealsContext>().allMeals,
        );

  MealsPage.favourites(BuildContext ctx)
      : this(
          title: "Favourites",
          meals: ctx.watch<MealsContext>().favourites,
        );

  @override
  Widget build(BuildContext context) {
    var color = this.color ?? Theme.of(context).primaryColor;
    var filters = context.watch<FiltersBloc>().state;

    var meals = context.watch<MealsContext>().allMeals.withFilters(filters).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
        actions: [
          FilterAppBarAction(),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.33),
        itemBuilder: (ctx, index) => Container(
          margin: const EdgeInsets.all(15).copyWith(bottom: 0),
          child: MealTile(
            meals[index].id,
            onSelect: () => navigateToMeal(context, meals[index]),
            placeholderColor: color,
          ),
        ),
        itemCount: meals.length,
      ),
    );
  }
}
