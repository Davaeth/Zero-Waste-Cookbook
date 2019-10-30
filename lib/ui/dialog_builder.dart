import 'package:flutter/material.dart';
import 'package:template_name/src/models/review.dart';
import 'package:template_name/src/models/user.dart';
import 'package:template_name/src/pages/one_recipe/components/review_rater.dart';
import 'package:template_name/ui/shared/page_resolvers/navigator.dart';

import 'shared/colors/default_colors.dart';
import 'shared/page_resolvers/positioning.dart';

class DialogBuilder extends StatefulWidget {
  List<Review> _reviews;
  Function _singleRecipeCallback;

  DialogBuilder(this._reviews, this._singleRecipeCallback);

  @override
  _DialogBuilderState createState() => _DialogBuilderState();
}

class _DialogBuilderState extends State<DialogBuilder> {
  List<Review> _reviews;
  Function _singleRecipeCallback;

  TextEditingController _descriptionController;

  int _rateValue;

  @override
  void initState() {
    _reviews = widget._reviews;
    _descriptionController = TextEditingController();
    _singleRecipeCallback = widget._singleRecipeCallback;

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
        _reviews.add(Review(
            User('Belkowen', 'eee'), _descriptionController.text, _rateValue));

        stepPageBack(context);

        _singleRecipeCallback();
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
