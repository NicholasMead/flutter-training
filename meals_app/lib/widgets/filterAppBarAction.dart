import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/filtersContext.dart';

enum FilterOptions {
  vegan,
  lactoseFree,
  glutenFree,
  all,
}

class FilterAppBarAction extends StatefulWidget {
  const FilterAppBarAction({Key? key}) : super(key: key);

  @override
  _FilterAppBarActionState createState() => _FilterAppBarActionState();
}

class _FilterAppBarActionState extends State<FilterAppBarAction> {
  PopupMenuEntry _buildMenuItem({
    required String name,
    required FilterOptions value,
    required bool active,
  }) {
    return PopupMenuItem(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          if (active)
            Icon(
              Icons.done,
              color: Colors.black54,
            ),
        ],
      ),
      value: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtersContext = context.watch<FiltersContext>();

    return PopupMenuButton(
      icon: Icon(Icons.filter_list_alt),
      itemBuilder: (_) {
        return <PopupMenuEntry>[
          _buildMenuItem(
            name: "Vegan",
            value: FilterOptions.vegan,
            active: filtersContext.showVegan,
          ),
          _buildMenuItem(
            name: "Glutten Free",
            value: FilterOptions.glutenFree,
            active: filtersContext.showGluttenFree,
          ),
          _buildMenuItem(
            name: "Lactose Free",
            value: FilterOptions.lactoseFree,
            active: filtersContext.showLactoseFree,
          ),
          _buildMenuItem(
            name: "Show All",
            value: FilterOptions.all,
            active: filtersContext.showAll,
          )
        ];
      },
      onSelected: (value) {
        switch (value) {
          case FilterOptions.vegan:
            filtersContext.showVegan = !filtersContext.showVegan;
            break;
          case FilterOptions.lactoseFree:
            filtersContext.showLactoseFree = !filtersContext.showLactoseFree;
            break;
          case FilterOptions.glutenFree:
            filtersContext.showGluttenFree = !filtersContext.showGluttenFree;
            break;
          case FilterOptions.all:
            filtersContext.setShowAll();
            break;
        }
      },
    );
  }
}
