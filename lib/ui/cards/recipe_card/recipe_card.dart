import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card/mixins/recipe_card_interior.dart';
import 'package:zero_waste_cookbook/ui/constants/enums/recipe_card_interior_type.dart';
import 'package:zero_waste_cookbook/ui/constants/enums/routes.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/stack_builder.dart';

class RecipeCard extends StatefulWidget {
  final String recipeID;
  final String userId;

  final bool isTappable;

  final RecipeCardInteriorType recipeCardInteriorType;

  final Recipe recipe;
  final IconData iconData;
  final Function(bool) callback;

  RecipeCard({
    @required this.recipeID,
    @required this.userId,
    @required this.recipeCardInteriorType,
    @required this.recipe,
    @required this.iconData,
    this.callback,
    this.isTappable = true,
  });

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> with RecipeCardInterior {
  String _recipeId;
  bool _isTappable;
  RecipeCardInteriorType _recipeCardInteriorType;

  Recipe _recipe;
  String _userId;
  IconData _iconData;
  Function(bool) _callback;

  @override
  Widget build(BuildContext context) => switchPage(
        context,
        Card(
          color: DefaultColors.secondaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: _buildInterior(context) ?? [Text('Ładuję!')],
          ),
        ),
        Routes.Recipe,
        recipeId: _recipeId,
        isTappable: _isTappable,
      );

  List<Widget> _buildInterior(BuildContext context) {
    switch (_recipeCardInteriorType) {
      case RecipeCardInteriorType.SingleRecipe:
        return createInteriorForRecipeCard(
          context: context,
          iconData: _iconData,
          recipe: _recipe,
          userId: _userId,
          callback: _callback,
          mainImage: StackBuilder.createImageWithFavButton(
            context: context,
            imagePath: GlobalConfiguration().getString("imagePath") +
                _recipe.photoPath,
          ),
        );
        break;
      case RecipeCardInteriorType.RecipePage:
        return createInteriorForRecipeCard(
          context: context,
          iconData: _iconData,
          recipe: _recipe,
          userId: _userId,
          callback: _callback,
          ratings: buildRatings(recipe: _recipe),
          mainImage: StackBuilder.createImageWithIconButtons(
            context: context,
            imagePath: GlobalConfiguration().getString("imagePath") +
                _recipe.photoPath,
          ),
        );
        break;
      default:
        return [Text('Ładuję!')];
    }
  }

  @override
  void initState() {
    _recipeId = widget.recipeID;
    _isTappable = widget.isTappable;
    _recipeCardInteriorType = widget.recipeCardInteriorType;

    _recipe = widget.recipe;
    _userId = widget.userId;
    _iconData = widget.iconData;
    _callback = widget.callback;

    super.initState();
  }
}
