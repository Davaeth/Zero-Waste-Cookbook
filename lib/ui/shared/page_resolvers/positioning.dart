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

CustomScrollView wrapWithScrollingView(Widget page) =>
    CustomScrollView(slivers: <Widget>[
      SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 2000.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: .5),
          delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => page,
              childCount: 1)),
    ]);
