import 'package:firebase_storage_image/firebase_storage_image.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'shared/colors/default_colors.dart';

class StackBuilder {
  static Stack createImageWithFavButton(
          {@required BuildContext context,
          @required bool isSingle,
          @required String imagePath,
          @required bool isFav,
          @required String recipeId,
          @required String userId,
          Function(bool) callback}) =>
      Stack(
        alignment: Alignment.topRight,
        children: <Widget>[

          new Container(
              width: MediaQuery.of(context).size.width, //* (isSingle ? 1.0 : 0.6),
              height: MediaQuery.of(context).size.width * 9/16, // * (isSingle ? 1.0 : 0.6),
              decoration: new BoxDecoration(
//                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: (FirebaseStorageImage(imagePath) == null) ? AssetImage('assets/images/ic_launcher.png') : FirebaseStorageImage(imagePath),
                  )
              )),


          _createFavIconButton(
              isFav: isFav,
              recipeId: recipeId,
              userId: userId,
              callback: callback)
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
          new Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 9/16,
              decoration: new BoxDecoration(
//                  shape: BoxShape.rectangle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: (FirebaseStorageImage(imagePath) == null) ? AssetImage('assets/images/ic_launcher.png') : FirebaseStorageImage(imagePath),
                  )
              )),

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
        userId, recipeId)) {
      _db.removeRecipeFromFavourites(recipeId, userId);
      callback(true);
    } else {
      _db.addRecipeToFavourites(recipeId, userId);
      callback(false);
    }
  }
}
