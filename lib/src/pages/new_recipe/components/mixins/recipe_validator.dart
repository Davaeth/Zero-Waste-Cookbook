import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/new_recipe.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

mixin RecipeValidator on State<NewRecipe> {
  bool checkTextField(String text) =>
      text != null && text != '' && text.trim() != '';

  void showWarningToast(String message) => Fluttertoast.showToast(
        msg: message,
        backgroundColor: DefaultColors.secondaryColor,
        textColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
}
