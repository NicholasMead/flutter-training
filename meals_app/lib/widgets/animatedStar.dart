import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedStar extends StatelessWidget {
  final AnimationController controller;
  final Color color;

  const AnimatedStar({
    required this.color,
    required this.controller,
    Key? key,
  }) : super(key: key);

  static AnimationController createController(TickerProvider vsync) =>
      AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: vsync,
      );

  @override
  Widget build(BuildContext context) {
    var animation = Tween<double>(begin: 0, end: 2).animate(controller);

    return LayoutBuilder(
      builder: (_, cx) {
        var maxSize = min(cx.maxHeight, cx.maxWidth);

        return AnimatedBuilder(
            animation: animation,
            builder: (_, __) {
              var scale =
                  animation.value < 1 ? animation.value : 2 - animation.value;

              return Opacity(
                opacity: 0.7 * scale,
                child: Icon(
                  Icons.star,
                  color: color,
                  size: maxSize * 0.8 * scale,
                ),
              );
            });
      },
    );
  }
}
