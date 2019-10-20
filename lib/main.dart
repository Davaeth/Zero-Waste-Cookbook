import 'package:flutter/material.dart';
import 'package:template_name/shared/behaviours/custom_scroll_behavior.dart';
import 'package:template_name/shared/enums/page.dart';
import 'package:template_name/shared/page_resolvers/navigator.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';
import 'package:template_name/shared/page_resolvers/page_resolver.dart';
import 'package:template_name/shared/ui/cards/recipe_card.dart';
import 'package:template_name/shared/ui/recipes/recipes_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Zero Waste Cookbook',
      builder: (context, child) => configureScrollBehavior(child),
      home: buildPage(context, Page.HomePage.index));
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
                Page.RecipePage),
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
            )
          ]));
}
