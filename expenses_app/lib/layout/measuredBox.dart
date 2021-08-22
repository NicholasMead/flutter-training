import 'package:flutter/material.dart';

class MeasuredBox extends StatefulWidget {
  final Widget? child;
  final Function(Size size)? onRenderedSize;

  MeasuredBox({
    this.onRenderedSize,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  _MeasuredBoxState createState() => _MeasuredBoxState();
}

class _MeasuredBoxState extends State<MeasuredBox> {
  final _key = GlobalKey();

  void _onLayout() {
    var size = _key.currentContext?.size;
    if (size != null) {
      if (widget.onRenderedSize != null) {
        widget.onRenderedSize!(size);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.onRenderedSize != null)
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        _onLayout();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(key: _key, child: widget.child);
  }
}
