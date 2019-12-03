import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/ingredient.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/difficulty_level.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/dish_region.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/new_recipe_section.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/recipe_ingredients.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

import 'components/dropdowns/difficulty_level_dropdown.dart';
import 'components/dropdowns/dish_regions_dropdown.dart';

class NewRecipe extends StatefulWidget {
  @override
  _NewRecipeState createState() => _NewRecipeState();
}

class RegionsDropdown {}

class _NewRecipeState extends State<NewRecipe> {
  TextEditingController _descriptionController;
  TextEditingController _titleController;
  TextEditingController _prepTimeController;

  List<Ingredient> _ingredients;
  DifficultyLevel _difficultyLevel;
  DishRegion _dishRegion;

  GlobalKey<NewRecipeSectionState> _newRecipeSectionKey;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        body: SafeArea(
          top: true,
          left: true,
          right: true,
          bottom: true,
          child: addPadding(
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _createBackButton(context),
                  _createTitleTextField(context),
                  _buildRecipeIngredients(),
                  _createDirectionsTextField(context),
                  _buildDifficultyLevelDropdown(),
                  _buildDishRegionsDropdown(),
                  _buildPerpTimeField(context),
                  _createAddRecipeButton(context),
                ],
              ),
              left: 32.0,
              right: 32.0),
        ),
      );

  NewRecipeSection _buildPerpTimeField(BuildContext context) {
    return NewRecipeSection(
      'Prep Time',
      _buildTextField(TextInputType.number, _prepTimeController, context),
    );
  }

  NewRecipeSection _buildDishRegionsDropdown() {
    return NewRecipeSection(
      'Regions',
      DishRegionsDropdown(
        callback: _dishRegionsDropdownCallback,
      ),
    );
  }

  NewRecipeSection _buildDifficultyLevelDropdown() {
    return NewRecipeSection(
      'Difficulty level',
      DifficultyLevelDropdown(
        callback: _difficultyLevelDropdownCallback,
      ),
    );
  }

  RecipeIngredients _buildRecipeIngredients() {
    return RecipeIngredients(
      _newRecipeSectionKey,
      _ingredientDialogCallback,
      _buildIngredientsListView(),
    );
  }

  @override
  void initState() {
    _ingredients = List<Ingredient>();
    _newRecipeSectionKey = GlobalKey<NewRecipeSectionState>();

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _prepTimeController = TextEditingController();

    super.initState();
  }

  void _addRecipe() {
    DatabaseService _databaseService = DatabaseService();

    List<String> ingredientsId = List<String>();

    for (var ingredient in _ingredients) {
      ingredientsId.add(ingredient.id);
    }

    _databaseService.createDatum(
      'Recipes',
      Recipe(
              recipeTitle: _titleController.text,
              prepTime: int.parse(_prepTimeController.text),
              description: _descriptionController.text,
              creationTime: Timestamp.fromDate(DateTime.now()),
              photoPath: null,
              rank: 0,
              deleted: false,
              difficultyLevel: _databaseService.getDocumentReference(
                  'DifficultyLevels', _difficultyLevel.id),
              dishRegions: _databaseService.getDocumentReference(
                  'DishRegions', _dishRegion.id),
              ingredients: _databaseService
                  .getDocumentsReferences(
                    'Ingredients',
                    ingredientsId,
                  )
                  .toList(),
              user: null)
          .toJson(),
    );
  }

  Row _buildIngredient(Ingredient ingredient) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          addPadding(
              Text(
                ingredient.ingredientName,
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              left: 8.0),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => _removeIngredient(ingredient),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: Colors.white,
          ),
        ],
      );

  ListView _buildIngredientsListView() => ListView.builder(
        shrinkWrap: true,
        itemCount: _ingredients.length,
        itemBuilder: (context, index) => _buildIngredient(_ingredients[index]),
      );

  Container _buildTextField(TextInputType inputType,
          TextEditingController controller, BuildContext context,
          {int maxLines = 1, int length = 20}) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: DefaultColors.secondaryColor,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          keyboardType: inputType,
          maxLines: maxLines,
          maxLength: length,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          textAlign: TextAlign.center,
          controller: controller,
          decoration:
              InputDecoration(border: InputBorder.none, counterText: ''),
        ),
      );

  Padding _createAddRecipeButton(BuildContext context) => addPadding(
        FlatButton(
          child: Text('Add recipe'),
          onPressed: () => _addRecipe(),
          color: DefaultColors.iconColor,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        top: 16.0,
        bottom: 16.0,
      );

  IconButton _createBackButton(BuildContext context) => IconButton(
        alignment: Alignment.topRight,
        icon: Icon(Icons.close),
        color: DefaultColors.iconColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 30.0,
        onPressed: () {
          stepPageBack(context);
        },
      );

  NewRecipeSection _createDirectionsTextField(BuildContext context) =>
      NewRecipeSection(
        'Directions',
        _buildTextField(
            TextInputType.multiline, _descriptionController, context,
            maxLines: null, length: null),
      );

  NewRecipeSection _createTitleTextField(BuildContext context) =>
      NewRecipeSection(
        'Title',
        _buildTextField(TextInputType.text, _titleController, context),
      );

  void _difficultyLevelDropdownCallback(DifficultyLevel difficultyLevel) {
    _difficultyLevel = difficultyLevel;
  }

  void _dishRegionsDropdownCallback(DishRegion dishRegion) {
    _dishRegion = dishRegion;
  }

  void _ingredientDialogCallback(Ingredient ingredient) {
    setState(
      () {
        _ingredients.add(ingredient);
        _newRecipeSectionKey.currentState.child = _buildIngredientsListView();
      },
    );
  }

  void _removeIngredient(Ingredient ingredient) {
    setState(() {
      _ingredients.remove(ingredient);
      _newRecipeSectionKey.currentState.child = _buildIngredientsListView();
    });
  }
}
