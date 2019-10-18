import 'package:flutter/material.dart';
import 'package:template_name/shared/behaviours/custom_scroll_behavior.dart';
import 'package:template_name/shared/enums/page.dart';
import 'package:template_name/shared/page_resolvers/navigator.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';
import 'package:template_name/shared/page_resolvers/page_resolver.dart';
import 'package:template_name/shared/ui/cards/recipe_card.dart';
import 'package:template_name/shared/ui/recipes/recipes_manager.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/ui/constants/custom_bottom_navigation_bar.dart';
import 'package:template_name/shared/ui/recipes/recipes_manager.dart';
import 'package:template_name/shared/ui/recipes/fav_recipes.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => wrapWithScrollingView(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            switchPage(
                context,
                UpperSection(),
                Page.RecipePage),
            addPadding(
                Text(
                  'Favorite recipes',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                left: 16.0,
                top: 16.0,
                bottom: 8.0),
            Expanded(
              child: FavRecipesManager(),
            )
          ]));
}  

class UpperSection extends StatelessWidget {
  const UpperSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 32.0,
        ),
        Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
                Icon(
                  Icons.star,
                  size: 64.0,
                  color: DefaultColors.iconColor
                ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                'Username',
                style: TextStyle(
                  fontSize: 24.0, color: Colors.white),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                'Cook',
                style: TextStyle(
                  fontSize: 20.0, color: Colors.white),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 48.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 32.0,
                    child:
                  Icon(
                    Icons.star,
                  color: DefaultColors.iconColor
                  ),
                  ),
                  Text(
                    '100k',
                    style: TextStyle(
                  fontSize: 20.0, color: Colors.white),
                  )
                  
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 32.0,
                    child:
                  Icon(
                    Icons.favorite,
                  color: DefaultColors.iconColor
                  ),
                  ),
                  Text(
                    '100k',
                    style: TextStyle(
                  fontSize: 20.0, color: Colors.white),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 32.0,
                    child:
                  Icon(
                    Icons.comment,
                  color: DefaultColors.iconColor
                  ),
                  ),
                  Text(
                    '100',
                   style: TextStyle(
                  fontSize: 20.0, color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}