import 'dart:async';

import 'package:flutter/material.dart';

class CustomInkWell extends StatefulWidget {
  CustomInkWell({
    Key key,
    this.margin,
    @required this.child,
    this.onPressed,
    this.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    this.elevation = 0,
    this.color = Colors.white,
    this.highlightColor,
    this.border,
    this.shape,
    this.boxShadow,
  }) : super(key: key);

  final EdgeInsetsGeometry margin;

  final Widget child;

  final Function onPressed;

  final Color color;

  final Color highlightColor;

  final double elevation;

  final BorderRadius borderRadius;

  final BoxBorder border;

  final List<BoxShadow> boxShadow;

  final BoxShape shape;

  @override
  _CustomInkWellState createState() => _CustomInkWellState();
}

class _CustomInkWellState extends State<CustomInkWell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child ?? Container();
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        border: widget.border,
        boxShadow: widget.boxShadow,
        borderRadius: widget.shape==null?widget.borderRadius:null,
        shape: widget.shape??BoxShape.rectangle,
      ),
      child: Material(
        color: widget.color,
        elevation: widget.elevation,
        borderRadius: widget.borderRadius,
        child: InkWell(
          borderRadius: widget.borderRadius,
          onTap: widget.onPressed,
          highlightColor: widget.highlightColor,
          child: child,
        ),
      ),
    );
  }
}
