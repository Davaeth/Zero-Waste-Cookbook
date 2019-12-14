import 'package:firebase_storage_image/firebase_storage_image.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/ui/constants/enums/routes.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

class SearchingResult extends StatelessWidget {
  final List<Recipe> _recipes;

  SearchingResult(this._recipes);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: ListView(
            shrinkWrap: true,
            children: [
              _buildCloseButton(context),
              ListView.builder(
                controller: ScrollController(),
                shrinkWrap: true,
                itemCount: _recipes.length,
                itemBuilder: (context, index) =>
                    _buildSingleListElement(context, index),
              ),
            ],
          ),
        ),
      );

  Padding _buildSingleListElement(BuildContext context, int index) =>
      addPadding(
        switchPage(
          context,
          Center(
            child: Container(
              alignment: Alignment.center,
              width: (MediaQuery.of(context).size.width / 100) * 90,
              height: (MediaQuery.of(context).size.height / 100) * 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: DefaultColors.secondaryColor,
              ),
              child: _buildRecipeTile(context, _recipes[index]),
            ),
          ),
          Routes.Recipe,
          recipeId: _recipes[index].id,
        ),
        bottom: 16.0,
      );

  Align _buildCloseButton(BuildContext context) => Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {
            stepPageBack(context);
          },
          icon: Icon(Icons.close),
          color: DefaultColors.iconColor,
          iconSize: 35.0,
        ),
      );

  ListTile _buildRecipeTile(BuildContext context, Recipe recipe) => ListTile(
        leading: Container(
          child:(
            Image(
          image: FirebaseStorageImage(
          GlobalConfiguration().getString("imagePath") + recipe.photoPath,),
          width: MediaQuery.of(context).size.width* 4 / 16,
          height: MediaQuery.of(context).size.width,
          )
          ),
        ),
        title: Text(
          recipe.recipeTitle,
          style: TextStyle(fontSize: 22.0, color: DefaultColors.textColor),
          textAlign: TextAlign.center,
        ),
        subtitle: _buildSubtitle(recipe.rank.toString()),
      );

  Row _buildSubtitle(String rank) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.star,
            color: DefaultColors.iconColor,
          ),
          addPadding(
            Text(
              rank,
              style: TextStyle(fontSize: 20.0, color: DefaultColors.textColor),
            ),
            left: 4.0,
          ),
        ],
      );
}
