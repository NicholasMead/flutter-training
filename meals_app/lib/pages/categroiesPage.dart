import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/categoryMealsPage.dart';
import '../widgets/categoryTile.dart';
import '../data/categoriesContext.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  VoidCallback createCategorySelect(BuildContext ctx, String id) {
    return () {
      Navigator.of(ctx).pushNamed(
        CategoryMealsPage.route,
        arguments: CategoryMealsPageArgs(id),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<CategoriesContext>().all;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: GridView(
        padding: EdgeInsets.all(15)
            .copyWith(bottom: MediaQuery.of(context).size.height * 0.25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        children: categories
            .map((cat) => CategoryTile(
                  title: cat.title,
                  color: cat.color,
                  onSelect: createCategorySelect(context, cat.id),
                ))
            .toList(),
      ),
    );
  }
}
