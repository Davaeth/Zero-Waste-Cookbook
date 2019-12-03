import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/pages/login/authentication.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/applications_actions.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/recipes_actions.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/users_actions.dart';
import 'package:zero_waste_cookbook/ui/constants/routes.dart';
import 'ui/cards/recipe_card.dart';
import 'ui/recipes/recipes_manager.dart';
import 'ui/shared/behaviours/custom_scroll_behavior.dart';
import 'ui/shared/page_resolvers/positioning.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Zero Waste Cookbook',
      builder: (context, child) => configureScrollBehavior(child),
      home: AuthenticationCheck(),
      routes: {
        Routes.AdministratorUsers: (context) => UsersActions(),
        Routes.AdministratorRecipes: (context) => RecipesActions(),
        Routes.AdministratorApplications: (context) => ApplicationsActions()
      },
      onGenerateRoute: Routes.handleGeneratingRoutes());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => wrapWithScrollingView(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildRecipeOfTheDay(),
            addPadding(
                Text(
                  'Nowe przepisy',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                left: 16.0,
                top: 16.0,
                bottom: 8.0),
            Expanded(
              child: Container(
                height: (MediaQuery.of(context).size.height / 100) * 80,
                child: RecipesManager(),
              ),
            ),
          ],
        ),
      );

  FutureBuilder _buildRecipeOfTheDay() {
    DatabaseService _db = DatabaseService();

    return FutureBuilder(
      future: _db.getDatumByID('Recipes', 'Bxu5wk2DKnA14VzCtDlh'),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        var recipe = Recipe.fromFirestore(snapshot.data);

        return RecipeCard(
          interior: RecipeCard.createInteriorForSingleCard(
            recipe: recipe,
            imagePath: 'assets/images/small-food.png',
            userId: 'MtcBAWcygoW6ERK83agC',
          ),
        );
      },
    );
  }
}
