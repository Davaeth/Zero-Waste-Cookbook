import 'package:firebase_storage_image/firebase_storage_image.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'shared/colors/default_colors.dart';

class StackBuilder {
  static Container createImageWithFavButton({
    @required String imagePath,
    @required BuildContext context,
  }) =>
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9 / 16,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: (FirebaseStorageImage(imagePath) == null)
                ? AssetImage('assets/images/ic_launcher.png')
                : FirebaseStorageImage(imagePath),
          ),
        ),
      );

  static Stack createImageWithIconButtons({
    @required String imagePath,
    @required BuildContext context,
  }) =>
      Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 9 / 16,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: (FirebaseStorageImage(imagePath) == null)
                    ? AssetImage('assets/images/ic_launcher.png')
                    : FirebaseStorageImage(imagePath),
              ),
            ),
          ),
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
        ],
      );
}
