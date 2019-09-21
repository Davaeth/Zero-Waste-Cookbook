import 'package:flutter/material.dart';

class Ratings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  @override
  Widget build(BuildContext context) => Row(
        children: _createFavouriteIcons(3),
      );

  static List<Icon> _createFavouriteIcons(int rating) => List<Icon>.generate(
      5,
      (i) => Icon(
            (i + 1) <= rating ? Icons.star : Icons.star_border,
            size: 27.0,
            color: Colors.orange,
          ));
}
