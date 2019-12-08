import 'package:firebase_storage_image/firebase_storage_image.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';

import 'shared/colors/default_colors.dart';

class StackBuilder {
  static Stack createImageWithFavButton(
          {@required String imagePath,
          @required IconData icon,
          @required String recipeId,
          @required String userId}) =>
      Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Image(image: FirebaseStorageImage(imagePath)),
          _createFavIconButton(icon: icon, recipeId: recipeId, userId: userId)
        ],
      );

  static Stack createImageWithIconButtons(
          {@required String imagePath,
          @required IconData icon,
          @required String recipeId,
          @required String userId,
          @required BuildContext context}) =>
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
          _createFavIconButton(icon: icon, recipeId: recipeId, userId: userId)
        ],
      );

  static _addRecipeToFavs(String recipeId, String userId) {
    DatabaseService _db = DatabaseService();

    _db.addRecipeToFavourites(recipeId, userId);

    print('I AAAAAAM');
  }

  static IconButton _createFavIconButton(
          {@required IconData icon,
          @required String recipeId,
          @required String userId}) =>
      IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(icon),
        onPressed: () => _addRecipeToFavs(recipeId, userId),
        iconSize: 40.0,
        color: DefaultColors.iconColor,
      );
}
