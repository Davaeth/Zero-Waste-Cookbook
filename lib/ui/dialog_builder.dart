import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/administration/review.dart';
import 'package:zero_waste_cookbook/src/pages/single_recipe/components/review_rater.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';

import 'shared/colors/default_colors.dart';
import 'shared/page_resolvers/positioning.dart';

class DialogBuilder extends StatefulWidget {
  final Function singleRecipeCallback;
  final String recipeId;

  DialogBuilder({this.singleRecipeCallback, this.recipeId});

  @override
  _DialogBuilderState createState() => _DialogBuilderState();
}

class _DialogBuilderState extends State<DialogBuilder> {
  Function _singleRecipeCallback;

  TextEditingController _descriptionController;

  int _rateValue;
  String _recipeId;

  @override
  void initState() {
    _descriptionController = TextEditingController();
    _singleRecipeCallback = widget.singleRecipeCallback;
    _recipeId = widget.recipeId;

    super.initState();
  }

  @override
  Widget build(BuildContext context) => _buildRateReviewDialog();

  SimpleDialog _buildRateReviewDialog() => SimpleDialog(
        contentPadding: EdgeInsets.only(top: 0, bottom: 16.0),
        backgroundColor: DefaultColors.secondaryColor,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              stepPageBack(context);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            alignment: Alignment.topRight,
          ),
          Center(
              child: Text(
            'Rate the recipe',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          )),
          ReviewRater(_rateReview),
          _craeteReviewDesctiptionField(),
          _createSubmitButotn(),
        ],
        elevation: 0,
      );

  Padding _craeteReviewDesctiptionField() => addPadding(
      Container(
        color: DefaultColors.backgroundColor,
        child: TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            textAlign: TextAlign.center,
            controller: _descriptionController,
            decoration: InputDecoration(border: InputBorder.none)),
      ),
      left: 16.0,
      right: 16.0);

  Padding _createSubmitButotn() => addPadding(
      MaterialButton(
        onPressed: addReview,
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

  void _rateReview(int rateValue) {
    _rateValue = rateValue;
  }

  void addReview() {
    setState(() {
      if (_rateValue != null) {
        DatabaseService _db = DatabaseService();

        _db.createDatum(
          'Reviews',
          Review(
            rate: _rateValue,
            description: _descriptionController.text,
            reviewType: 'Cool',
            user: _db.getDocumentReference('Users', 'MtcBAWcygoW6ERK83agC'),
            recipe: _db.getDocumentReference('Recipes', _recipeId),
          ).toJson(),
        );

        _db.updateRecipeRank(_recipeId);

        setState(() {
          _singleRecipeCallback();
        });

        stepPageBack(context);
      } else {
        // Builder(
        //   builder: (BuildContext context) {
        //     return Scaffold.of(context).showSnackBar(SnackBar(
        //       content: Text('Przepis musi być oceniony!'),
        //     ));
        //   },
        // );
      }
    });
  }
}
