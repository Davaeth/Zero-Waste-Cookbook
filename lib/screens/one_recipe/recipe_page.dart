import 'package:flutter/material.dart';
import 'package:template_name/screens/one_recipe/components/reviews.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';
import 'package:template_name/shared/page_resolvers/screen_builder.dart';
import 'package:template_name/shared/ui/dialog_builder.dart';
import 'package:template_name/shared/ui/expansion_tiles/expansion_tile_builder.dart';
import 'package:template_name/shared/ui/expansion_tiles/section.dart';
import 'package:template_name/shared/ui/cards/recipe_card.dart';

class RecipePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int _reviewCount = 3;
  bool areReviewsExpanded = false;

  RecipeCard recipeCard = RecipeCard(RecipeCard.createInteriorForCardWithRating(
      'assets/images/small-food.png', 'elo', 'elo1'));

  @override
  Widget build(BuildContext context) => buildPage(
        context,
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            recipeCard,
            addPadding(
                ExpansionTileBuilder(Section('INGREDIENTS',
                    entries: ['Test1', 'Test2', 'Test3'])),
                top: 4.0,
                bottom: 8.0),
            addPadding(
                ExpansionTileBuilder(Section('DESCRIPTION', entries: [
                  'Integer egestas orci sapien, sed tristique massa facilisis eget. Sed pharetra vulputate scelerisque. Suspendisse in congue lorem, at sagittis augue. Pellentesque egestas convallis purus. Curabitur pretium a urna quis tristique. Nullam quis condimentum lacus. Sed nec sem ac dui efficitur ultrices. Mauris in leo nec sapien fermentum fringilla pharetra nec purus.'
                ])),
                bottom: 8.0),
            _createReviewAddingButton(),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: _reviewCount,
              itemBuilder: (context, index) => Reviews('Beleczka', 2),
            ),
            _createReviewExpandText()
          ],
        ),
      );

  void _expandReviews() {
    setState(() {
      _reviewCount = areReviewsExpanded ? 3 : 5;
      areReviewsExpanded = !areReviewsExpanded;
    });
  }

  Center _createReviewExpandText() => Center(
        child: GestureDetector(
          onTap: _expandReviews,
          child: addPadding(
              Text(
                areReviewsExpanded ? 'Pokaż mniej...' : 'Pokaż więcej...',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              top: 8.0,
              bottom: 8.0),
        ),
      );

  GestureDetector _createReviewAddingButton() => GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => DialogBuilder.buildRateReviewDialog());
        },
        child: Container(
          alignment: Alignment.center,
          color: DefaultColors.secondaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              addPadding(
                  Text(
                    'Dodaj komentarz',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  left: 16.0,
                  top: 8.0,
                  bottom: 8.0),
              addPadding(
                  Icon(
                    Icons.add,
                    color: Colors.orange,
                    size: 25.0,
                  ),
                  right: 16.0)
            ],
          ),
        ),
      );
}
