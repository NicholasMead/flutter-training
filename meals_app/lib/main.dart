import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meals_app/data/categoriesContext.dart';
import 'package:meals_app/data/filters_bloc.dart';
import 'package:meals_app/data/mealsContext.dart';
import 'package:meals_app/pages/mainPage.dart';
import 'package:meals_app/pages/mealDetailPage.dart';
import 'package:provider/provider.dart';

import 'pages/categoryMealsPage.dart';

void main() {
  runApp(MyApp());
}

typedef Widget ProviderBuilder(Widget child);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        MealsContext.asProvider(),
        CategoriesContext.asProvider(),
        BlocProvider(create: (_) => FiltersBloc()),
        //FiltersContext.asProvider(),
      ],
      child: MaterialApp(
        title: 'Food App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.lightBlueAccent,
          canvasColor: Colors.grey.shade50,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                headline6: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
        ),
        home: MainPage(), // CategoriesPage(),
        routes: {
          CategoryMealsPage.route: (_) => CategoryMealsPage(),
          MealDetailPage.route: (_) => MealDetailPage(),
        },
      ),
    );
  }
}
