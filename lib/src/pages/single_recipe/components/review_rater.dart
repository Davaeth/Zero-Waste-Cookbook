import 'package:flutter/material.dart';

class ReviewRater extends StatefulWidget {
  final Function _rateReview;

  ReviewRater(this._rateReview);

  @override
  ReviewRaterState createState() => ReviewRaterState();
}

class ReviewRaterState extends State<ReviewRater> {
  List<IconButton> _starButtons = List<IconButton>();
  Function _rateReview;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _starButtons,
      );

  @override
  void initState() {
    _starButtons = _createFavouriteIconButtonsWithRatedStatus().toList();
    _rateReview = widget._rateReview;
    super.initState();
  }

  IconButton _createFavouriteIconButton(int index, Icon icon) => IconButton(
        icon: icon,
        onPressed: () => _rateRecipe(index),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      );

  Iterable<IconButton> _createFavouriteIconButtonsWithRatedStatus() sync* {
    for (var i = 0; i < 5; i++) {
      yield _createFavouriteIconButton(i, _createRatingIcon(Icons.star_border));
    }
  }

  Icon _createRatingIcon(IconData icon) => Icon(
        icon,
        size: 27.0,
        color: Colors.orange,
      );

  void _rateRecipe(int index) {
    setState(() {
      _rateReview(index + 1);

      for (var i = 0; i < _starButtons.length; i++) {
        if (i <= index) {
          _starButtons[i] =
              _createFavouriteIconButton(i, _createRatingIcon(Icons.star));
          continue;
        }

        _starButtons[i] =
            _createFavouriteIconButton(i, _createRatingIcon(Icons.star_border));
      }
    });
  }
}
