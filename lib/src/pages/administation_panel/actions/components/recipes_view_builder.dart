import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/components/models/administrator_action.dart';
import 'package:zero_waste_cookbook/ui/recipes_tile.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';

class RecipesViewBuilder extends StatefulWidget {
  @override
  _RecipesViewBuilderState createState() => _RecipesViewBuilderState();
}

class _RecipesViewBuilderState extends State<RecipesViewBuilder> {
  List<Recipe> _recipes;

  AdministratorAction _administratorAction;

  DatabaseService _dbService;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              _buildMainRow(),
              FutureBuilder<QuerySnapshot>(
                future: _dbService.getAllData('Recipes'),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> recipesSnapshots) {
                  if (recipesSnapshots.hasData) {
                    _getRecipes(recipesSnapshots);

                    return ListView.builder(
                      controller: ScrollController(),
                      shrinkWrap: true,
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) => RecipeTile(
                        _recipes[index],
                        _callback,
                        onLongPressCallback:
                            _administratorAction.multipleSelect,
                        index: index,
                      ),
                    );
                  } else {
                    return ListTile();
                  }
                },
              ),
            ],
          ),
          top: true,
          bottom: true,
        ),
      );

  @override
  void initState() {
    _administratorAction = AdministratorAction();
    _recipes = List<Recipe>();
    _dbService = DatabaseService();

    super.initState();
  }

  StatelessWidget _buildDeleteSelectedButton() =>
      _administratorAction.areReadyToDelete
          ? _buildMainRowButtons(
              Icons.delete,
              Colors.red,
              _deleteRecipes,
            )
          : Icon(null);

  Row _buildMainRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildDeleteSelectedButton(),
          _buildMainRowButtons(
            Icons.close,
            DefaultColors.iconColor,
            _closePage,
          ),
        ],
      );

  IconButton _buildMainRowButtons(
          IconData iconData, Color color, Function pressedFunction) =>
      IconButton(
        icon: Icon(iconData),
        color: color,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        iconSize: 35.0,
        onPressed: () => pressedFunction(),
      );

  void _callback() {
    setState(() {});
  }

  void _closePage() => stepPageBack(context);

  Future<void> _deleteRecipes() async {
    setState(() {
      for (var index in _administratorAction.getIndexes) {
        _dbService.deleteDatum('Recipes', _recipes[index].id);

        _dbService.deleteDataByRelation(
          'Tags',
          'recipe',
          'Recipes',
          _recipes[index].id,
        );
        _dbService.deleteDataByRelation(
          'Reviews',
          'recipe',
          'Recipes',
          _recipes[index].id,
        );
        _dbService.deleteRelatedData(
          'Users',
          'userId',
          'recipes',
          'Recipes',
          _recipes[index].id,
        );
      }

      _administratorAction.setIndexes = List<int>();
      _administratorAction.setReadyToDelete = false;
    });
  }

  Future<void> _getRecipes(
      AsyncSnapshot<QuerySnapshot> recipesSnapshots) async {
    _recipes = List<Recipe>();

    recipesSnapshots.data.documents.forEach(
      (recipeSnapshot) => _recipes.add(Recipe.fromFirestore(recipeSnapshot)),
    );
  }
}
