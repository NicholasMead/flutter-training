import 'package:flutter/material.dart';
import 'package:meals_app/widgets/animatedStar.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

import '../data/mealsContext.dart';

class MealTile extends StatefulWidget {
  final VoidCallback onSelect;
  final String mealId;
  final Color? placeholderColor;

  const MealTile(
    this.mealId, {
    required this.onSelect,
    this.placeholderColor,
    Key? key,
  }) : super(key: key);

  @override
  _MealTileState createState() => _MealTileState();
}

class _MealTileState extends State<MealTile> with TickerProviderStateMixin {
  AnimationController? starController;

  void initState() {
    super.initState();
    starController = AnimatedStar.createController(this);
  }

  void setFavourate(BuildContext ctx, bool value) {
    ctx.read<MealsContext>().setFavorate(widget.mealId, value);
    starController?.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final mealContext = context.watch<MealsContext>();
    final meal = mealContext.mealById(widget.mealId);

    final radius = Radius.circular(10);

    final titleLable = Container(
      color: Colors.black.withOpacity(0.5),
      width: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            meal.title,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
            softWrap: true,
            overflow: TextOverflow.fade,
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 1000),
            transitionBuilder: (child, animation) => RotationTransition(
              turns: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: child,
            ),
            child: Icon(
              Icons.star,
              color: meal.isFavorite ? Colors.yellow : Colors.transparent,
              key: ValueKey("${meal.id}_${meal.isFavorite}"),
            ),
          ),
        ],
      ),
    );

    final titleImage = ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: radius,
        topRight: radius,
      ),
      child: LayoutBuilder(
        builder: (_, size) => Container(
          width: size.maxWidth,
          height: size.maxWidth * 9 / 16,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.placeholderColor != null
                    ? widget.placeholderColor!.withOpacity(0.7)
                    : Theme.of(context).primaryColor.withOpacity(0.7),
                widget.placeholderColor ?? Theme.of(context).primaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: meal.imageUrl,
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 200),
          ),
        ),
      ),
    );

    Widget buildTag(
      String name,
      Color backgroundColor, {
      Color textColor = Colors.white,
    }) =>
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          margin: EdgeInsets.only(top: 10, right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                )
              ]),
          child: Text(
            name,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: textColor,
                ),
          ),
        );

    final titleTags = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (meal.isLactoseFree) buildTag("Lactose Free", Colors.blue),
        if (meal.isGlutenFree)
          buildTag(
            "Gluten Free",
            Colors.yellow,
            textColor: Colors.black,
          ),
        if (meal.isVegan) buildTag("Vegan", Colors.green),
      ],
    );

    final info = Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TileInfo(
            icon: Icons.schedule,
            value: durationText(meal.duration),
          ),
          _TileInfo(
            icon: Icons.work,
            value: "${meal.complexity.toString().split(".")[1]}",
          ),
          _TileInfo(
            icon: Icons.attach_money_outlined,
            spacing: 1,
            value: "${meal.affordability.toString().split(".")[1]}",
          ),
        ],
      ),
    );

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(radius),
        ),
        elevation: 7,
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    titleImage,
                    Positioned(bottom: 0, left: 0, right: 0, child: titleLable),
                    Positioned(bottom: 0, right: 0, top: 0, child: titleTags),
                    Positioned.fill(
                      child: AnimatedStar(
                        controller: starController!,
                        color: meal.isFavorite ? Colors.yellow : Colors.red,
                      ),
                    ),
                  ],
                ),
                info
              ],
            ),
            Positioned.fill(
              child: InkWell(
                onTap: widget.onSelect,
                onLongPress: () => setFavourate(context, !meal.isFavorite),
                borderRadius: BorderRadius.all(radius),
                splashColor: Theme.of(context).primaryColor,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ],
        ));
  }
}

class _TileInfo extends StatelessWidget {
  final IconData icon;
  final double spacing;
  final String value;

  const _TileInfo({
    required this.icon,
    required this.value,
    this.spacing = 6,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: spacing,
        ),
        Text(value),
      ],
    );
  }
}

String durationText(int mins) {
  final hrs = (mins / 60).floor();
  mins = mins % 60;

  final List<String> output = [];

  if (hrs > 0) output.add("$hrs hrs");
  if (mins > 0) output.add("$mins mins");

  return output.join(" ");
}
