import 'package:flutter/material.dart';

Padding addPadding(Widget widget,
        {double left = 0,
        double top = 0,
        double right = 0,
        double bottom = 0}) =>
    Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: widget,
    );
