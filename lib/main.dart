import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/components/recipes_view_builder.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/components/users_view_builder.dart';
import 'package:zero_waste_cookbook/src/pages/login/authentication.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card/recipe_card.dart';
import 'package:zero_waste_cookbook/ui/constants/enums/recipe_card_interior_type.dart';
import 'package:zero_waste_cookbook/ui/constants/enums/routes.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';
import 'package:zero_waste_cookbook/utils/routes_arguments.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

import 'ui/recipes/recipes_manager.dart';
import 'ui/shared/behaviours/custom_scroll_behavior.dart';
import 'ui/shared/page_resolvers/positioning.dart';

import 'package:global_configuration/global_configuration.dart';

final FirebaseStorage storage = FirebaseStorage(
    app: Firestore.instance.app,
    storageBucket: 'gs://zero-waste-cookbook.appspot.com/');

void main() async {
  await GlobalConfiguration().loadFromAsset("appconfig");

  await Translator.instance.getTranslations();

  return runApp(MyApp(false));
}

class MyApp extends StatelessWidget {
  final bool _isLogged;

  MyApp(this._isLogged);

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Zero Waste Cookbook',
      builder: (context, child) => configureScrollBehavior(child),
      home: AuthenticationCheck(_isLogged),
      routes: {
        Routes.AdministratorUsers: (context) => UsersViewBuilder(),
        Routes.AdministratorRecipes: (context) => RecipesViewBuilder(),
      },
      onGenerateRoute: Routes.handleGeneratingRoutes());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isFav;

  Recipe _recipe;

  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        children: <Widget>[
          addPadding(
            Text(
              Translator.instance.translations['recipe_of_the_day'],
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            left: 16.0,
            top: 16.0,
            bottom: 8.0,
          ),
          _buildRecipeOfTheDay(context),
          addPadding(
              Text(
                Translator.instance.translations['newest_recipes'],
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              left: 16.0,
              top: 16.0,
              bottom: 8.0),
          Container(
            height: (MediaQuery.of(context).size.height / 100) * 50,
            child: RecipesManager(
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      );

  @override
  void initState() {
    _isFav = false;
    super.initState();
  }

  FutureBuilder _buildRecipeOfTheDay(BuildContext context) {
    DatabaseService _db = DatabaseService();

    return FutureBuilder<DocumentSnapshot>(
      future: _db.getDatumByID('Recipes', 'HX0dEwMcGXLNr3AFrSLe'),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          _recipe = Recipe.fromFirestore(snapshot?.data);

          return RecipeCard(
            recipeCardInteriorType: RecipeCardInteriorType.SingleRecipe,
            recipe: _recipe,
            userId: currentUserId,
            callback: (bool isFav) => _callback(isFav),
            recipeID: _recipe.id,
            isFav: _isFav,
          );
        } else {
          return Card();
        }
      },
    );
  }

  _callback(bool isFav) {
    setState(() {
      _isFav = isFav;
    });
  }
}
