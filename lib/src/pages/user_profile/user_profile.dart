import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/constants/routes.dart';
import 'package:zero_waste_cookbook/ui/recipes/fav_recipes.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';
import 'package:zero_waste_cookbook/ui/user_profile/user_button.dart';
import 'package:zero_waste_cookbook/ui/user_profile/user_info.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => wrapWithScrollingView(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            settingsButton(context, 4),
            buildUserInfo(
              ['100k', '2'],
              [Icons.star, Icons.comment],
              currentUserName,
              currentUserIamgeUrl,
            ),
            buildUserButtonsRow(
              context,
              [
                Translator.instance.translations['add_new_recipe'],
                Translator.instance.translations['manage_my_recipes']
              ],
              [Routes.NewRecipePage, Routes.UserRecipesManager],
            ),
            addPadding(
              Text(
                Translator.instance.translations['favourite_recipes'],
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
              left: 10.0,
              top: 8.0,
              bottom: 8.0,
            ),
            Expanded(
              child: FavRecipesManager(),
            )
          ],
        ),
      );
}
