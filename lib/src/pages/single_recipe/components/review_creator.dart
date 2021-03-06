import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/dialog_builder.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

class ReviewCreator extends StatelessWidget {
  final Function _singleRecipeCallback;
  final String _recipeId;

  ReviewCreator(this._singleRecipeCallback, this._recipeId);

  @override
  Widget build(BuildContext context) => _createReviewAddingButton(context);

  GestureDetector _createReviewAddingButton(BuildContext context) =>
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => DialogBuilder(
              singleRecipeCallback: _singleRecipeCallback,
              recipeId: _recipeId,
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          color: Colors.orange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              addPadding(
                Text(
                  Translator.instance.translations['add_review'],
                  style: TextStyle(
                    color: DefaultColors.secondaryColor,
                    fontSize: 15.0,
                  ),
                ),
                left: 16.0,
                top: 8.0,
                bottom: 8.0,
              ),
              addPadding(
                Icon(
                  Icons.add,
                  color: DefaultColors.secondaryColor,
                  size: 25.0,
                ),
                right: 16.0,
              )
            ],
          ),
        ),
      );
}
