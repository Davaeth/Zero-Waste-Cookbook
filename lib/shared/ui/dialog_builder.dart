import 'package:flutter/material.dart';
import 'package:template_name/screens/one_recipe/components/ratings__to_be_rated.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';

class DialogBuilder {
  static SimpleDialog buildRateReviewDialog() => SimpleDialog(
        contentPadding: EdgeInsets.only(top: 0, bottom: 16.0),
        backgroundColor: DefaultColors.secondaryColor,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {},
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            alignment: Alignment.topRight,
          ),
          Center(
              child: Text(
            'Rate the recipe',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          )),
          RatingsToBeRated(),
          _craeteReviewDesctiptionField(),
          _createSubmitButotn(),
        ],
        elevation: 0,
      );

  static Padding _craeteReviewDesctiptionField() => addPadding(
      Container(
        color: DefaultColors.backgroundColor,
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          textAlign: TextAlign.center,
        ),
      ),
      left: 16.0,
      right: 16.0);

  static Padding _createSubmitButotn() => addPadding(
      MaterialButton(
        onPressed: () {},
        color: DefaultColors.iconColor,
        child: Text('SUBMIT'),
        textColor: Colors.black,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      bottom: 0,
      top: 8.0,
      left: 16.0,
      right: 16.0);
}
