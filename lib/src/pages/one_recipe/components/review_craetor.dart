import 'package:flutter/material.dart';
import 'package:template_name/src/models/review.dart';
import 'package:template_name/ui/dialog_builder.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';

class ReviewCreator extends StatelessWidget {
  List<Review> _reviews;
  Function _singleRecipeCallback;

  ReviewCreator(this._reviews, this._singleRecipeCallback);

  @override
  Widget build(BuildContext context) => _createReviewAddingButton(context);

  GestureDetector _createReviewAddingButton(BuildContext context) =>
      GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) =>
                  DialogBuilder(_reviews, _singleRecipeCallback));
        },
        child: Container(
          alignment: Alignment.center,
          color: DefaultColors.secondaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              addPadding(
                  Text(
                    'Dodaj komentarz',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  left: 16.0,
                  top: 8.0,
                  bottom: 8.0),
              addPadding(
                  Icon(
                    Icons.add,
                    color: Colors.orange,
                    size: 25.0,
                  ),
                  right: 16.0)
            ],
          ),
        ),
      );
}
