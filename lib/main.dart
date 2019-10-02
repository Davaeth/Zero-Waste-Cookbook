import 'package:flutter/material.dart';
import 'package:template_name/pages/one_recipe/recipe_page.dart';
import 'package:template_name/shared/behaviours/custom_scroll_behavior.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';
import 'package:template_name/shared/page_resolvers/screen_builder.dart';
import 'package:template_name/shared/ui/recipes/recipe_card.dart';
import 'package:template_name/shared/ui/recipes/recipes_menager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) => configureScrollBehavior(child),
      home: buildPage(context, MyHomePage()));
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => wrapWithScrollingView(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RecipePage()));
              },
              child: RecipeCard(RecipeCard.createInteriorForSingleCard(
                  'assets/images/small-food.png',
                  'Belka stulejka',
                  'Beleczka')),
            ),
            addPadding(
                Text(
                  'Nowe przepisy',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                left: 16.0,
                top: 16.0,
                bottom: 8.0),
            Expanded(
              child: RecipesMenager(),
            )
          ]));
}
