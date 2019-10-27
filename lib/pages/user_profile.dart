import 'package:flutter/material.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/enums/page.dart';
import 'package:template_name/shared/page_resolvers/navigator.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';
import 'package:template_name/shared/ui/recipes/fav_recipes.dart';
import 'package:template_name/shared/ui/user_profile/user_info.dart';
import 'package:template_name/shared/ui/user_profile/user_button.dart';
import 'package:template_name/pages/administation_panel/administrator_panel.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => wrapWithScrollingView(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            settingsButton(context, 4),
            switchPage(
                context,
                buildUserInfo(['100k','2'], [Icons.star, Icons.comment], 'BoyMan'),
                Page.RecipePage),
                buildUserButtonsRow(context, ['Add new recipe', 'Manage my recipes'], [1,2]),
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
          ]));
}