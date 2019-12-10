import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/models/food/ingredient.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

import 'dropdowns/ingredients_dropdown.dart';

class AddRecipeDialog extends StatefulWidget {
  final Function(Ingredient) _newRecipeCallback;

  AddRecipeDialog(this._newRecipeCallback);

  @override
  _AddRecipeDialogState createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends State<AddRecipeDialog> {
  Function(Ingredient) _newRecipeCallback;

  Ingredient _ingredient;

  @override
  Widget build(BuildContext context) => _buildRateReviewDialog();

  @override
  void initState() {
    _newRecipeCallback = widget._newRecipeCallback;

    super.initState();
  }

  void _addAnIngredient() {
    setState(() {
      _newRecipeCallback(_ingredient);

      stepPageBack(context);
    });
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
            'Wybierz składnik',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          )),
          _createIngredientDropdown(),
          _createAddIngredientButton()
        ],
        elevation: 0,
      );

  _chooseAnIngredient(Ingredient ingredient) {
    setState(() {
      _ingredient = ingredient;
    });
  }

  Padding _createAddIngredientButton() => addPadding(
      MaterialButton(
        onPressed: () => _addAnIngredient(),
        color: DefaultColors.iconColor,
        child: Text('Dodaj'),
        textColor: Colors.black,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      left: 16.0,
      right: 16.0);

  Padding _createIngredientDropdown() => addPadding(
      Container(
        color: DefaultColors.backgroundColor,
        child: IngredientsDropdown(callback: _chooseAnIngredient),
      ),
      left: 16.0,
      right: 16.0,
      top: 16.0);
}
