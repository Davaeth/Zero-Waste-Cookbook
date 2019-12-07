import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

class UserRecipesManagerItem extends StatefulWidget {
  final Recipe recipe;
  final Function callback;

  UserRecipesManagerItem({@required this.recipe, @required this.callback});

  @override
  _UserRecipesManagerItemState createState() => _UserRecipesManagerItemState();
}

class _UserRecipesManagerItemState extends State<UserRecipesManagerItem>
    with TickerProviderStateMixin {
  AnimationController _iconAnimationController;

  Recipe _recipe;

  bool _isSelected;

  Function _callback;

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          alignment: Alignment.center,
          width: (MediaQuery.of(context).size.width / 100) * 90,
          height: (MediaQuery.of(context).size.height / 100) * 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: DefaultColors.secondaryColor,
          ),
          child: _buildUserRecipesTile(),
        ),
      );

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _isSelected = false;
    _callback = widget.callback;

    super.initState();
  }

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

  ListTile _buildUserRecipesTile() {
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _recipe = widget.recipe;

    return ListTile(
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
        onPressed: () => _handleIconButton(),
        icon: Icon(
          Icons.delete,
          size: 35.0,
          color: DefaultColors.iconColor,
        ),
      ),
    );
  }

  _handleIconButton() {
    setState(() {
      DatabaseService _db = DatabaseService();

      _db.deleteDatum('Recipes', _recipe.id);
      _db.deleteDataByRelation('Tags', 'recipe', 'Recipes', _recipe.id);
      _db.deleteRelatedData(
          'Users', 'userId', 'recipes', 'Recipes', _recipe.id);

      _callback();
    });
  }
}

// Container(
//           width: (MediaQuery.of(context).size.width / 100) * 90,
//           height: (MediaQuery.of(context).size.height / 100) * 15,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0), color: Colors.red),
//         ),
