import 'package:firebase_storage_image/firebase_storage_image.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';

import 'shared/colors/default_colors.dart';

class StackBuilder {
  static Stack createImageWithFavButton(
          {@required String imagePath,
          @required bool isFav,
          @required String recipeId,
          @required String userId,
          Function(bool) callback}) =>
      Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Image(image: FirebaseStorageImage(imagePath)),
          _createFavIconButton(icon: icon, recipeId: recipeId, userId: userId)

        ],
      );

  static Stack createImageWithIconButtons(
          {@required String imagePath,
          @required bool isFav,
          @required String recipeId,
          @required String userId,
          @required BuildContext context,
          Function(bool) callback}) =>
      Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Image(image: FirebaseStorageImage(imagePath)),
          //Image.asset(imagePath),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                stepPageBack(context);
              },
              iconSize: 24.0,
              color: DefaultColors.iconColor,
            ),
          ),
          _createFavIconButton(
              isFav: isFav,
              recipeId: recipeId,
              userId: userId,
              callback: callback)
        ],
      );

  static IconButton _createFavIconButton(
          {@required bool isFav,
          @required String recipeId,
          @required String userId,
          Function(bool) callback}) =>
      IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
        onPressed: () =>
            _handleFavRecipeIconButton(recipeId, userId, callback: callback),
        iconSize: 40.0,
        color: DefaultColors.iconColor,
      );

  static _handleFavRecipeIconButton(String recipeId, String userId,
      {Function callback}) async {
    DatabaseService _db = DatabaseService();

    if (await _db.checkIfRecipeIsFaved(
        'E5ewEF8YxDO0rl8Zue2zMrU7Yd43', recipeId)) {
      _db.removeRecipeFromFavourites(recipeId, 'E5ewEF8YxDO0rl8Zue2zMrU7Yd43');
      callback(true);
    } else {
      _db.addRecipeToFavourites(recipeId, 'E5ewEF8YxDO0rl8Zue2zMrU7Yd43');
      callback(false);
    }
  }
}
