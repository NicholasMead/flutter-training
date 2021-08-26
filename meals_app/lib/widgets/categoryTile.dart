import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onSelect;

  const CategoryTile({
    required this.title,
    required this.color,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);

    return InkWell(
      onTap: onSelect,
      borderRadius: borderRadius,
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        child: Center(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
      ),
    );
  }
}
