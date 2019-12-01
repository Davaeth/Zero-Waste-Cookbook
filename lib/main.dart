import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/pages/login/authentication.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/applications_actions.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/recipes_actions.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/users_actions.dart';
import 'package:zero_waste_cookbook/ui/constants/routes.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'ui/cards/recipe_card.dart';
import 'ui/recipes/recipes_manager.dart';
import 'ui/shared/behaviours/custom_scroll_behavior.dart';
import 'ui/shared/page_resolvers/page_resolver.dart';
import 'ui/shared/page_resolvers/positioning.dart';
import 'package:zero_waste_cookbook/src/pages/login/login_page.dart';

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
  Widget build(BuildContext context) => wrapWithScrollingView(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RecipeCard(
                interior: RecipeCard.createInteriorForSingleCard(
                    'assets/images/small-food.png',
                    'Najmniejszy obiad świata!',
                    '30 minut')),
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
                  child: RecipesManager()),
            ),
            IconButton(
              icon: Icon(
                Icons.perm_contact_calendar,
                color: Colors.white,
              ),
              onPressed: () {
                navigateToPageByRoute(Routes.VotingPage, context);
                // DatabaseService _db = DatabaseService();

                // Recipe recipe = Recipe(
                //     recipeTitle: 'Mój pierwszy autorski przepis!',
                //     creationTime: DateTime.now(),
                //     deleted: false,
                //     difficultyLevel: 'Hard',
                //     dishRegions: 'Region',
                //     photoPath: '',
                //     prepTime: 1,
                //     rank: 1,
                //     reviews: [],
                //     user: '0.5 godziny');

                // _db.createDatum('Recipes', recipe.toJson());
              },
            ),
          ]
        )
      );
}
