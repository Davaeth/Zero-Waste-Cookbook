import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/constants/routes.dart';
import 'package:zero_waste_cookbook/ui/recipes/fav_recipes.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';
import 'package:zero_waste_cookbook/ui/user_profile/user_button.dart';
import 'package:zero_waste_cookbook/ui/user_profile/user_info.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => wrapWithScrollingView(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            settingsButton(context, 4),
            buildUserInfo(
                ['100k', '2'], [Icons.star, Icons.comment], name, imageUrl),
            buildUserButtonsRow(
                context,
                ['Add new recipe', 'Manage my recipes'],
                [Routes.NewRecipePage, Routes.UserRecipesManager]),
            addPadding(
                Text(
                  'Favourite recipes',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                left: 16.0,
                top: 8.0,
                bottom: 8.0),
            Expanded(
              child: FavRecipesManager(),
            )
          ],
        ),
      );
}
