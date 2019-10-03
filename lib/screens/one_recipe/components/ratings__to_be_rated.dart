import 'package:flutter/material.dart';

class RatingsToBeRated extends StatefulWidget {
  @override
  _RatingsEditable createState() => _RatingsEditable();
}

class _RatingsEditable extends State<RatingsToBeRated> {
  List<IconButton> _starButtons = List<IconButton>();

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _starButtons,
      );

  Iterable<IconButton> _createFavouriteIconButtonsWithRatedStatus() sync* {
    for (var i = 0; i < 5; i++) {
      yield _createFavouriteIconButton(i, _createRatingIcon(Icons.star_border));
    }
  }

  void _rateRecipe(int index) {
    setState(() {
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

  IconButton _createFavouriteIconButton(int index, Icon icon) => IconButton(
        icon: icon,
        onPressed: () => _rateRecipe(index),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      );

  Icon _createRatingIcon(IconData icon) => Icon(
        icon,
        size: 27.0,
        color: Colors.orange,
      );

  @override
  void initState() {
    _starButtons = _createFavouriteIconButtonsWithRatedStatus().toList();
    super.initState();
  }
}
