import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/ingredient.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/difficulty_level.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/region.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/tag.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/mixins/recipe_dropdowns.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/mixins/recipe_validator.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/new_recipe_section.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/recipe_ingredients.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/add_photo.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

class NewRecipe extends StatefulWidget {
  @override
  _NewRecipeState createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe>
    with RecipeDropdowns, RecipeValidator {
  TextEditingController _descriptionController;
  TextEditingController _titleController;
  TextEditingController _prepTimeController;
  List<TextEditingController> tagsControllers;

  List<Ingredient> _ingredients;
  DifficultyLevel _difficultyLevel;
  Region _dishRegion;

  GlobalKey<NewRecipeSectionState> _newRecipeSectionKey;
  GlobalKey<NewRecipeSectionState> _tagsSectionKey;

  String _recipePhoto;

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
                _createAddPhotoButton(),
                _buildRecipeIngredients(),
                _createDescriptionsTextField(context),
                buildDifficultyLevelDropdown(_difficultyLevelDropdownCallback),
                buildDishRegionsDropdown(_dishRegionsDropdownCallback),
                _buildPerpTimeField(context),
                _buildTagsSection(),
                _createAddRecipeButton(context),
              ],
            ),
            left: 16.0,
            right: 16.0,
          ),
        ),
      );

  @override
  void initState() {
    _ingredients = List<Ingredient>();

    _newRecipeSectionKey = GlobalKey<NewRecipeSectionState>();
    _tagsSectionKey = GlobalKey<NewRecipeSectionState>();

    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _prepTimeController = TextEditingController();
    tagsControllers = List<TextEditingController>();

    tagsControllers.add(TextEditingController());

    _recipePhoto = 'recipe${new DateTime.now().millisecondsSinceEpoch}';

    super.initState();
  }

  void _addNewTag() {
    tagsControllers.add(TextEditingController());

    _tagsSectionKey.currentState.setState(() {
      _tagsSectionKey.currentState.child = _buildTagsTextFields();
    });
  }

  Future<void> _addRecipeAndTags() async {
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
        photoPath: _recipePhoto,
        rank: 0,
        difficultyLevel: _databaseService.getDocumentReference(
            'DifficultyLevels', _difficultyLevel.id),
        dishRegions:
            _databaseService.getDocumentReference('Regions', _dishRegion.id),
        ingredients: _databaseService
            .getDocumentsReferences(
              'Ingredients',
              ingredientsId,
            )
            .toList(),
        user: _databaseService.getDocumentReference('Users', currentUserId),
      ).toJson(),
    );

    var _newestRecipe = await _databaseService
        .getNewestRecipes(limit: 1)
        .then((value) => value.documents.single.reference);

    for (var tag in tagsControllers) {
      if (checkTextField(tag.text)) {
        _databaseService.createDatum(
          'Tags',
          Tag(
            tagName: tag.text,
            recipe: _newestRecipe,
          ).toJson(),
        );
      }
    }

    _databaseService.addRecipeToUser(
      _newestRecipe.documentID,
      currentUserId,
      'recipes',
    );

    Fluttertoast.showToast(
      msg: Translator.instance.translations['recipe_added'],
      backgroundColor: DefaultColors.secondaryColor,
      textColor: Colors.greenAccent,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  NewRecipeSection _createAddPhotoButton() => NewRecipeSection(
        Translator.instance.translations['picture'],
        AddPhoto(photoPath: _recipePhoto),
      );

  Row _buildIngredient(Ingredient ingredient) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          addPadding(
            Text(
              Translator.instance.translations['ingredients_list']
                  [ingredient.name],
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            left: 8.0,
          ),
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

  NewRecipeSection _buildPerpTimeField(BuildContext context) =>
      NewRecipeSection(
        Translator.instance.translations['prep_time'],
        _buildTextField(TextInputType.number, _prepTimeController, context),
      );

  RecipeIngredients _buildRecipeIngredients() => RecipeIngredients(
        _newRecipeSectionKey,
        _ingredientDialogCallback,
        _buildIngredientsListView(),
      );

  Column _buildTagsSection() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NewRecipeSection(
            Translator.instance.translations['tags'],
            _buildTagsTextFields(),
            key: _tagsSectionKey,
          ),
          addPadding(
            FlatButton(
              color: Colors.transparent,
              onPressed: () {
                setState(
                  () => _addNewTag(),
                );
              },
              child: Text(Translator.instance.translations['add_new_tag'],
                  style: TextStyle(color: Colors.grey)),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.grey)),
            ),
            top: 8.0,
          ),
        ],
      );

  ListView _buildTagsTextFields() => ListView.builder(
        shrinkWrap: true,
        itemCount: tagsControllers.length,
        itemBuilder: (context, index) => addPadding(
          _buildTextField(TextInputType.text, tagsControllers[index], context),
          top: 8.0,
          bottom: 8.0,
        ),
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
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
        ),
      );

  Future<void> _checkRecipeData() async {
    if (!checkTextField(_titleController.text)) {
      return showWarningToast(
          Translator.instance.translations['provide_recipe_title']);
    }

    if (_ingredients.length <= 0) {
      return showWarningToast(
          Translator.instance.translations['provide_ingredients']);
    }

    if (!checkTextField(_descriptionController.text)) {
      return showWarningToast(
          Translator.instance.translations['provide_directions']);
    }

    if (!checkTextField(_prepTimeController.text)) {
      return showWarningToast(
          Translator.instance.translations['provide_prep_time']);
    }

    var firstTagText = tagsControllers.first.text;
    if (!checkTextField(firstTagText)) {
      return showWarningToast(Translator.instance.translations['provide_tags']);
    }

    await _addRecipeAndTags();
  }

  Padding _createAddRecipeButton(BuildContext context) => addPadding(
        FlatButton(
          child: Text(Translator.instance.translations['add_recipe']),
          onPressed: () => _checkRecipeData(),
          color: DefaultColors.iconColor,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
          ),
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

  NewRecipeSection _createDescriptionsTextField(BuildContext context) =>
      NewRecipeSection(
        Translator.instance.translations['directions'],
        _buildTextField(
            TextInputType.multiline, _descriptionController, context,
            maxLines: null, length: null),
      );

  NewRecipeSection _createTitleTextField(BuildContext context) =>
      NewRecipeSection(
        Translator.instance.translations['title'],
        _buildTextField(TextInputType.text, _titleController, context),
      );

  void _difficultyLevelDropdownCallback(DifficultyLevel difficultyLevel) {
    _difficultyLevel = difficultyLevel;
  }

  void _dishRegionsDropdownCallback(Region dishRegion) {
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
