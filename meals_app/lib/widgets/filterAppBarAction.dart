import 'package:flutter/material.dart';

//enum FilterOptions.

class FilterAppBarAction extends StatefulWidget {
  const FilterAppBarAction({Key? key}) : super(key: key);

  @override
  _FilterAppBarActionState createState() => _FilterAppBarActionState();
}

class _FilterAppBarActionState extends State<FilterAppBarAction> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.filter_list_alt),
      itemBuilder: (_) {
        return <PopupMenuEntry>[
          PopupMenuItem(child: Text("Vegan")),
          PopupMenuItem(child: Text("Lactose Free")),
          PopupMenuItem(child: Text("Glutten Free")),
        ];
      },
      //onSelected: ,
    );
  }
}
