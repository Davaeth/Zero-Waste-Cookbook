import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

import 'constants/routes.dart';

class RecipeTile extends StatelessWidget {
  final Recipe _recipe;
  final Function _setStateCallback;
  final Function(int, Function) onLongPressCallback;
  final int index;

  RecipeTile(
    this._recipe,
    this._setStateCallback, {
    this.onLongPressCallback,
    this.index,
  });

  @override
  Widget build(BuildContext context) => addPadding(
        Center(
          child: Container(
            alignment: Alignment.center,
            width: (MediaQuery.of(context).size.width / 100) * 90,
            height: (MediaQuery.of(context).size.height / 100) * 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: DefaultColors.secondaryColor,
            ),
            child: _buildUserRecipesTile(context),
          ),
        ),
        top: 16.0,
      );

  Row _buildSubtitle() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.star,
            color: DefaultColors.iconColor,
          ),
          addPadding(
            Text(
              _recipe.rank.toString(),
              style: TextStyle(fontSize: 20.0, color: DefaultColors.textColor),
            ),
            left: 4.0,
          ),
        ],
      );

  ListTile _buildUserRecipesTile(BuildContext context) => ListTile(
        onTap: () => navigateToPageByRoute(
          Routes.Recipe,
          context,
          recipeId: _recipe.id,
        ),
        onLongPress: () => onLongPressCallback(index, _setStateCallback),
        leading: Icon(
          Icons.text_fields,
          size: 55.0,
          color: DefaultColors.iconColor,
        ),
        title: Text(
          _recipe.recipeTitle,
          style: TextStyle(fontSize: 30.0, color: DefaultColors.textColor),
          textAlign: TextAlign.center,
        ),
        subtitle: _buildSubtitle(),
        trailing: IconButton(
          onPressed: () => _handleDeleteButton(),
          icon: Icon(
            Icons.delete,
            size: 35.0,
            color: DefaultColors.iconColor,
          ),
        ),
      );

  _handleDeleteButton() {
    DatabaseService _db = DatabaseService();

    _db.deleteDatum('Recipes', _recipe.id);
    _db.deleteDataByRelation('Tags', 'recipe', 'Recipes', _recipe.id);
    _db.deleteDataByRelation('Reviews', 'recipe', 'Recipes', _recipe.id);
    _db.deleteRelatedData('Users', 'userId', 'recipes', 'Recipes', _recipe.id);

    _setStateCallback();
  }
}
