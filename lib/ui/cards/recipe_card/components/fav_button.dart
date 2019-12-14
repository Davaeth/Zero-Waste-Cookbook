import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

class FavButton extends StatefulWidget {
  final String recipeId;
  final String userId;
  final Function callback;

  final Function _handleFavButtonCallback;

  FavButton(this.recipeId, this.userId, this._handleFavButtonCallback,
      {this.callback});

  @override
  FavButtonState createState() => FavButtonState();
}

class FavButtonState extends State<FavButton> {
  String _recipeId;
  String _userId;
  Function _callback;

  IconButton _favButton;
  Function(String, String, Function) _handleFavButtonCallback;

  @override
  Widget build(BuildContext context) => _favButton;

  @override
  void initState() {
    _favButton = _createFavouriteIconButtonWithRatedStatus();
    _handleFavButtonCallback = widget._handleFavButtonCallback;
    super.initState();
  }

  IconButton _createFavouriteIconButton(Icon icon) => IconButton(
        icon: icon,
        onPressed: () => _handleFavButton,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        iconSize: 40.0,
        color: DefaultColors.iconColor,
      );

  IconButton _createFavouriteIconButtonWithRatedStatus() =>
      _createFavouriteIconButton(_createRatingIcon(Icons.favorite_border));

  Icon _createRatingIcon(IconData icon) => Icon(icon);

  void _handleFavButton(int index) {
    setState(() {
      _handleFavButtonCallback(_recipeId, _userId, _callback);

      _favButton =
          _createFavouriteIconButton(_createRatingIcon(Icons.favorite));
    });
  }
}
