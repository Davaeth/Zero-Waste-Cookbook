import 'package:flutter/material.dart';
import 'package:template_name/components/custom_bottom_app_bar.dart';
import 'package:template_name/components/colors/default_colors.dart';
import 'package:template_name/components/recipes/recipe_card.dart';
import 'package:template_name/components/recipes/recipes_menager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      );
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        bottomNavigationBar: CustomBottomAppBar.createButtomAppBar(context),
        body: CustomScrollView(slivers: <Widget>[
          SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 2000.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: .5),
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RecipeCard(RecipeCard.createInteriorForSingleCard(
                                'assets/images/small-food.png',
                                'Belka stulejka',
                                'Beleczka')),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, top: 16.0, bottom: 8.0),
                              child: Text(
                                'Nowe przepisy',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                            Expanded(
                              child: RecipesMenager(),
                            )
                          ]),
                  childCount: 1))
        ]),
      );
}
