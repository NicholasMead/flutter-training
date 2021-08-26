import 'package:flutter/material.dart';

import './mealsPage.dart';
import './categroiesPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentTab = 0;

  final tabBuilders = <Widget Function(BuildContext)>[
    (ctx) => MealsPage.all(ctx),
    (_) => CategoriesPage(),
    (ctx) => MealsPage.favourites(ctx),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBuilders[_currentTab].call(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (index) => setState(() => _currentTab = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "All",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favourites",
          ),
        ],
      ),
    );
  }
}
