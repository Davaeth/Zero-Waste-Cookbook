import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/administration/review.dart';
import 'package:zero_waste_cookbook/src/pages/single_recipe/components/review_rater.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

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

  void _checkReviewData() {
    setState(() {
      if (_descriptionController.text == null ||
          _descriptionController.text == '' ||
          _descriptionController.text.trim() == '') {
        return _showWarningToast(
            Translator.instance.translations['provide_review_text']);
      }

      if (_rateValue == null) {
        return _showWarningToast(
            Translator.instance.translations['provide_review_rate']);
      }

      _addReview();
    });
  }

  void _showWarningToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: DefaultColors.secondaryColor,
      textColor: Colors.red,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void _addReview() {
    DatabaseService _db = DatabaseService();

    _db.createDatum(
      'Reviews',
      Review(
        rate: _rateValue,
        description: _descriptionController.text,
        reviewType: 'Cool',
        user: _db.getDocumentReference('Users', currentUserId),
        recipe: _db.getDocumentReference('Recipes', _recipeId),
      ).toJson(),
    );

    _db.updateRecipeRank(_recipeId);

    setState(() {
      _singleRecipeCallback();
    });

    stepPageBack(context);
  }

  @override
  Widget build(BuildContext context) => _buildRateReviewDialog();

  @override
  void initState() {
    _descriptionController = TextEditingController();
    _singleRecipeCallback = widget.singleRecipeCallback;
    _recipeId = widget.recipeId;

    super.initState();
  }

  SimpleDialog _buildRateReviewDialog() => SimpleDialog(
        contentPadding: EdgeInsets.only(top: 0, bottom: 16.0),
        backgroundColor: DefaultColors.secondaryColor,
        children: <Widget>[
          _buildCloseButton(),
          Center(
            child: Text(
              Translator.instance.translations['rate_the_recipe'],
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          ReviewRater(_rateReview),
          _craeteReviewDesctiptionField(),
          _createSubmitButotn(),
        ],
        elevation: 0,
      );

  IconButton _buildCloseButton() => IconButton(
        icon: Icon(Icons.close, color: Colors.white),
        onPressed: () {
          stepPageBack(context);
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        alignment: Alignment.topRight,
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
        right: 16.0,
      );

  Padding _createSubmitButotn() => addPadding(
        MaterialButton(
          onPressed: _checkReviewData,
          color: DefaultColors.iconColor,
          child: Text(Translator.instance.translations['submit'].toUpperCase()),
          textColor: Colors.black,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        bottom: 0,
        top: 8.0,
        left: 16.0,
        right: 16.0,
      );

  void _rateReview(int rateValue) {
    _rateValue = rateValue;
  }
}
