import 'package:flutter/material.dart';

class RadioBox extends StatefulWidget {
  final double? height;
  final double? width;
  final double radio;

  RadioBox.withHieght({
    required double height,
    required double radio,
    Key? key,
  })  : this.height = height,
        this.radio = radio,
        this.width = null,
        super(key: key);

  RadioBox.withWidth({
    required double width,
    required double radio,
    Key? key,
  })  : this.height = null,
        this.radio = radio,
        this.width = width,
        super(key: key);

  @override
  _RadioBoxState createState() => _RadioBoxState();
}

class _RadioBoxState extends State<RadioBox> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
