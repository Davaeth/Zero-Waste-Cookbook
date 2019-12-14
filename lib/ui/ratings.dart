import 'package:flutter/material.dart';

class Ratings extends StatefulWidget {
  final int _ratingValue;

  Ratings(this._ratingValue);

  @override
  State<StatefulWidget> createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  int _ratingValue;

  @override
  Widget build(BuildContext context) => Row(
        children: _createFavouriteIcons(),
      );

  List<Icon> _createFavouriteIcons() => List<Icon>.generate(
        5,
        (i) => Icon(
          (i + 1) <= _ratingValue ? Icons.star : Icons.star_border,
          size: 25.0,
          color: Colors.orange,
        ),
      );

  @override
  void initState() {
    _ratingValue = widget._ratingValue;

    super.initState();
  }
}
