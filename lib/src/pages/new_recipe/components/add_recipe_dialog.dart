import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/models/administration/review.dart';
import 'package:zero_waste_cookbook/ui/custom_dropdown.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

class AddRecipeDialog extends StatefulWidget {
  final List<Review> _reviews;
  final Function _singleRecipeCallback;

  AddRecipeDialog(this._reviews, this._singleRecipeCallback);

  @override
  _AddRecipeDialogState createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends State<AddRecipeDialog> {
  List<Review> _reviews;
  Function _singleRecipeCallback;

  int _rateValue;

  void addReview() {
    setState(() {
      if (_rateValue != null) {
        // _reviews.add(Reviews(Users(username: 'Belkowen', id: '2'),
        //     _descriptionController.text, _rateValue));

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

  @override
  Widget build(BuildContext context) => _buildRateReviewDialog();

  @override
  void initState() {
    _reviews = widget._reviews;
    _singleRecipeCallback = widget._singleRecipeCallback;

    super.initState();
  }

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
            'Choose an ingredient',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          )),
          _createIngredientDropdown()
        ],
        elevation: 0,
      );

  Padding _createIngredientDropdown() => addPadding(
      Container(
        color: DefaultColors.backgroundColor,
        child: CustomDropdown(),
      ),
      left: 16.0,
      right: 16.0);
}
