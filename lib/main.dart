import 'package:flutter/material.dart';
import 'package:template_name/src/pages/administation_panel/actions/applications_actions.dart';
import 'package:template_name/src/pages/administation_panel/actions/recipes_actions.dart';
import 'package:template_name/src/pages/administation_panel/actions/users_actions.dart';
import 'package:template_name/src/pages/login/authentication.dart';
import 'package:template_name/src/pages/one_recipe/single_recipe.dart';
import 'package:template_name/ui/constants/routes.dart';
import 'ui/cards/recipe_card.dart';
import 'ui/recipes/recipes_manager.dart';
import 'ui/shared/behaviours/custom_scroll_behavior.dart';
import 'ui/shared/page_resolvers/navigator.dart';
import 'ui/shared/page_resolvers/page_resolver.dart';
import 'ui/shared/page_resolvers/positioning.dart';
import 'package:template_name/src/pages/login/login_page.dart';

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
        Routes.AdministratorApplications: (context) => ApplicationsActions(),
        Routes.Recipe: (context) => SingleRecipe()
      },
      onGenerateRoute: Routes.handleGeneratingRoutes());
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => wrapWithScrollingView(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            switchPage(
                context,
                RecipeCard(RecipeCard.createInteriorForSingleCard(
                    'assets/images/small-food.png',
                    'Belka stulejka',
                    'Beleczka')),
                Routes.Recipe),
            addPadding(
                Text(
                  'Nowe przepisy',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                left: 16.0,
                top: 16.0,
                bottom: 8.0),
            Expanded(
              child: RecipesManager(),
            ),
            IconButton(
              icon: Icon(
                Icons.perm_contact_calendar,
                color: Colors.white,
              ),
              onPressed: () {
                navigateToPageByRoute(Routes.VotingPage, context);
              },
            ),
          ]
        )
      );
}
