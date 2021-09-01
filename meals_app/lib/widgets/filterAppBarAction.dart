import 'package:flutter/material.dart';
import 'package:meals_app/data/filters_bloc.dart';
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
    final filtersContext = context.watch<FiltersBloc>();

    return PopupMenuButton(
      icon: Icon(Icons.filter_list_alt),
      itemBuilder: (_) {
        return <PopupMenuEntry>[
          _buildMenuItem(
            name: "Vegan",
            value: FilterOptions.vegan,
            active: filtersContext.state.showVegan,
          ),
          _buildMenuItem(
            name: "Gluten Free",
            value: FilterOptions.glutenFree,
            active: filtersContext.state.showGlutenFree,
          ),
          _buildMenuItem(
            name: "Lactose Free",
            value: FilterOptions.lactoseFree,
            active: filtersContext.state.showLactoseFree,
          ),
          PopupMenuDivider(),
          _buildMenuItem(
            name: "Show All",
            value: FilterOptions.all,
            active: filtersContext.state.showAll,
          )
        ];
      },
      onSelected: (value) {
        switch (value) {
          case FilterOptions.vegan:
            filtersContext.add(SetFilterEvent(showVegan: !filtersContext.state.showVegan));
            break;
          case FilterOptions.lactoseFree:
            filtersContext
                .add(SetFilterEvent(showLactoseFree: !filtersContext.state.showLactoseFree));
            break;
          case FilterOptions.glutenFree:
            filtersContext
                .add(SetFilterEvent(showGlutenFree: !filtersContext.state.showGlutenFree));
            break;
          case FilterOptions.all:
            filtersContext.add(ClearFiltersEvent());
            break;
        }
      },
    );
  }
}
