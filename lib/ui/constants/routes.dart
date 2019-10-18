import 'package:flutter/material.dart';
import 'package:template_name/main.dart';
import 'package:template_name/src/pages/administation_panel/actions/applications_actions.dart';
import 'package:template_name/src/pages/administation_panel/actions/recipes_actions.dart';
import 'package:template_name/src/pages/administation_panel/actions/users_actions.dart';
import 'package:template_name/src/pages/one_recipe/single_recipe.dart';
import 'package:template_name/src/pages/voting/fake_recipe/fake_recipe.dart';
import 'package:template_name/src/pages/voting/voting.dart';

class Routes {
  static const Home = '/';
  static const AdministratorUsers = '/administration/users';
  static const AdministratorRecipes = '/administration/recipes';
  static const AdministratorApplications = '/administration/applications';
  static const Recipe = '/recipe';
  static const FakeRecipePage = '/voting/fakeRecipe';
  static const VotingPage = '/voting';

  static handleGeneratingRoutes() => (RouteSettings routes) {
        switch (routes.name) {
          case Routes.AdministratorUsers:
            return MaterialPageRoute(builder: (context) => UsersActions());
            break;
          case Routes.AdministratorRecipes:
            return MaterialPageRoute(
                builder: (context) => ApplicationsActions());
            break;
          case Routes.AdministratorApplications:
            return MaterialPageRoute(builder: (context) => RecipesActions());
            break;
          case Routes.Recipe:
            return MaterialPageRoute(builder: (context) => SingleRecipe());
            break;
          case Routes.FakeRecipePage:
            return MaterialPageRoute(builder: (context) => FakeRecipe());
            break;
          case Routes.VotingPage:
            return MaterialPageRoute(builder: (context) => Voting());
            break;
        }

        return MaterialPageRoute(builder: (context) => MyHomePage());
      };
}
