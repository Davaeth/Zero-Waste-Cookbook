import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/components/users_view_builder.dart';
import 'package:zero_waste_cookbook/src/pages/search/sreaching_result/searching_result.dart';
import 'package:zero_waste_cookbook/src/pages/user_profile/user_profile.dart';
import 'package:zero_waste_cookbook/main.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/recipes_actions.dart';
import 'package:zero_waste_cookbook/src/pages/login/login_page.dart';
import 'package:zero_waste_cookbook/src/pages/new_recipe/new_recipe.dart';
import 'package:zero_waste_cookbook/src/pages/search/search_filters.dart';
import 'package:zero_waste_cookbook/src/pages/search/search_page.dart';
import 'package:zero_waste_cookbook/src/pages/single_recipe/single_recipe.dart';
import 'package:zero_waste_cookbook/src/pages/user_profile/recipes_manager/user_recipes_manager.dart'
    as prefix0;
import 'package:zero_waste_cookbook/src/pages/user_profile/user_profile_settings.dart';
import 'package:zero_waste_cookbook/src/pages/voting/fake_recipe/fake_recipe.dart';
import 'package:zero_waste_cookbook/src/pages/voting/voting.dart';
import 'package:zero_waste_cookbook/src/utils/routes_arguments.dart';

class Routes {
  static const Home = '/';
  static const AdministratorUsers = '/administration/users';
  static const AdministratorRecipes = '/administration/recipes';
  static const Recipe = '/recipe';
  static const FakeRecipePage = '/voting/fakeRecipe';
  static const VotingPage = '/voting';
  static const FiltersPage = '/search/search_filters';
  static const SearchingResultPage = '/search/search_filters/searching_result';
  static const SearchPage = '/search/search_page';
  static const LoginPage = '/login/login_page';
  static const SettingsPage = '/user_profile/user_profile_settings';
  static const UserRecipesManager = '/user_profile/user_recipes_manager';
  static const NewRecipePage = '/user_profile/new_recipe';
  static const UserProfilePage = '/user_profile/user_profile';

  static handleGeneratingRoutes() => (RouteSettings routes) {
        final RoutesArguments routesArguments = routes.arguments;

        switch (routes.name) {
          case Routes.AdministratorUsers:
            return MaterialPageRoute(builder: (context) => UsersViewBuilder());
            break;
          case Routes.AdministratorRecipes:
            return MaterialPageRoute(builder: (context) => RecipesActions());
            break;
          case Routes.Recipe:
            return MaterialPageRoute(
                builder: (context) =>
                    SingleRecipe(recipeID: routesArguments.recipeId));
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
          case Routes.SearchingResultPage:
            return MaterialPageRoute(
                builder: (context) => SearchingResult(routesArguments.recipes));
            break;
          case Routes.LoginPage:
            return MaterialPageRoute(builder: (context) => Login());
            break;
          case Routes.SettingsPage:
            return MaterialPageRoute(builder: (context) => Settings());
            break;
          case Routes.UserRecipesManager:
            return MaterialPageRoute(
                builder: (context) => prefix0.UserRecipesManager());
            break;
          case Routes.NewRecipePage:
            return MaterialPageRoute(builder: (context) => NewRecipe());
            break;
          case Routes.UserProfilePage:
            return MaterialPageRoute(builder: (context) => UserProfile());
            break;
        }

        return MaterialPageRoute(builder: (context) => MyHomePage());
      };
}
