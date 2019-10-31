import 'package:flutter/material.dart';
import 'package:template_name/main.dart';
import 'package:template_name/src/pages/administation_panel/actions/applications_actions.dart';
import 'package:template_name/src/pages/administation_panel/actions/recipes_actions.dart';
import 'package:template_name/src/pages/administation_panel/actions/users_actions.dart';
import 'package:template_name/src/pages/one_recipe/single_recipe.dart';
import 'package:template_name/src/pages/voting/fake_recipe/fake_recipe.dart';
import 'package:template_name/src/pages/voting/voting.dart';
import 'package:template_name/src/pages/search/search_filters.dart';
import 'package:template_name/src/pages/search/search_page.dart';
import 'package:template_name/src/pages/user_profile/user_profile_settings.dart';
import 'package:template_name/src/pages/login/login_page.dart';

class Routes {
  static const Home = '/';
  static const AdministratorUsers = '/administration/users';
  static const AdministratorRecipes = '/administration/recipes';
  static const AdministratorApplications = '/administration/applications';
  static const Recipe = '/recipe';
  static const FakeRecipePage = '/voting/fakeRecipe';
  static const VotingPage = '/voting';
  static const FiltersPage ='/search/search_filters';
  static const SearchPage ='/search/search_page';
  static const LoginPage ='/login/login_page';
  static const SettingsPage = '/user_profile/user_profile_settings';

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
          case Routes.FiltersPage:
            return MaterialPageRoute(builder: (context) => Filters());
            break;
          case Routes.SearchPage:
            return MaterialPageRoute(builder: (context) => Search());
            break;
          case Routes.LoginPage:
            return MaterialPageRoute(builder: (context) => Login());
            break;   
          case Routes.SettingsPage:
            return MaterialPageRoute(builder: (context) => Settings());
            break;            
        }

        return MaterialPageRoute(builder: (context) => MyHomePage());
      };
}
