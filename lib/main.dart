import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/applications_actions.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/recipes_actions.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/users_actions.dart';
import 'package:zero_waste_cookbook/src/pages/login/authentication.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/components/add_photo.dart';
import 'package:zero_waste_cookbook/ui/constants/routes.dart';

import 'ui/cards/recipe_card.dart';
import 'ui/recipes/recipes_manager.dart';
import 'ui/shared/behaviours/custom_scroll_behavior.dart';
import 'ui/shared/page_resolvers/positioning.dart';


import 'package:global_configuration/global_configuration.dart';

final FirebaseStorage storage = FirebaseStorage(
      app: Firestore.instance.app,
      storageBucket: 'gs://zero-waste-cookbook.appspot.com/');

void main() async{
  await GlobalConfiguration().loadFromAsset("appconfig");
  runApp(MyApp());


class MyApp extends StatelessWidget {
  final bool _isLogged;

  MyApp(this._isLogged);

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Zero Waste Cookbook',
      builder: (context, child) => configureScrollBehavior(child),
      home: AuthenticationCheck(_isLogged),
      routes: {
        Routes.AdministratorUsers: (context) => UsersActions(),
        Routes.AdministratorRecipes: (context) => RecipesActions(),
        Routes.AdministratorApplications: (context) => ApplicationsActions()
      },
      onGenerateRoute: Routes.handleGeneratingRoutes());
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isFav;
  @override
  Widget build(BuildContext context) => wrapWithScrollingView(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildRecipeOfTheDay(),
            addPadding(
                Text(
                  'Newest recipes',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                left: 16.0,
                top: 16.0,
                bottom: 8.0),
            Expanded(
              child: Container(
                height: (MediaQuery.of(context).size.height / 100) * 50,
                child: RecipesManager(),

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

  FutureBuilder _buildRecipeOfTheDay() {
    DatabaseService _db = DatabaseService();

    return FutureBuilder<DocumentSnapshot>(
      future: _db.getDatumByID('Recipes', '9dINDS1sKiIJglqtmAXE'),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          Recipe recipe = Recipe.fromFirestore(snapshot?.data);

          return RecipeCard(
            interior: RecipeCard.createInteriorForSingleCard(
              recipe: recipe,
              userId: 'MtcBAWcygoW6ERK83agC',
              isFav: _isFav,
              callback: (bool isFav) => _callback(isFav),
            ),
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
