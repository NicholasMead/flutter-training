import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailPageArgs {
  final Meal meal;

  const MealDetailPageArgs({required this.meal});
}

class MealDetailPage extends StatelessWidget {
  static String get route => "/meal-detail";

  const MealDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as MealDetailPageArgs;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.meal.title),
      ),
      body: Center(
        child: Text(args.meal.title),
      ),
    );
  }
}
