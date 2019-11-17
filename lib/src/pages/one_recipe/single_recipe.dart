import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:template_name/src/models/review.dart';
import 'package:template_name/src/models/user.dart';
import 'package:template_name/src/pages/one_recipe/components/review_creator.dart';
import 'package:template_name/ui/cards/recipe_card.dart';
import 'package:template_name/ui/expansion_tiles/expansion_tile_builder.dart';
import 'package:template_name/ui/expansion_tiles/section.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';

import 'components/reviews.dart';

class SingleRecipe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SingleRecipeState();
}

class _SingleRecipeState extends State<SingleRecipe>
    with AfterLayoutMixin<SingleRecipe> {
  User _user;
  List<Review> _reviews;
  int _reviewsCountToShow = 0;
  bool _areReviewsExpanded = false;

  GlobalKey<ReviewsState> _reviewsStateKey = GlobalKey<ReviewsState>();

  @override
  void afterFirstLayout(BuildContext context) {
    _expandReviews();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          backgroundColor: DefaultColors.backgroundColor,
          body: ListView(
            shrinkWrap: true,
            children: <Widget>[
              RecipeCard(RecipeCard.createInteriorForCardWithRating(
                  'assets/images/small-food.png', 'elo', 'elo1', context)),
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
              ReviewCreator(_reviews, _callback),
              Reviews(
                _user,
                _reviews,
                _reviewsCountToShow,
                key: _reviewsStateKey,
              ),
              _createReviewExpandText()
            ],
          ),
        ),
      );

  @override
  void initState() {
    _user = User(id:'123456', username: 'Belka');
    _reviews = List<Review>();

    _reviews.add(Review(_user, 'Jesteś najlepszy!', 2));
    _reviews.add(Review(_user, 'Słabe', 1));
    _reviews.add(Review(_user, 'Meh', 3));
    _reviews.add(Review(_user, 'Kozak kery', 5));
    _reviews.add(Review(_user, 'Prawie izak', 4));

    super.initState();
  }

  Center _createReviewExpandText() => Center(
        child: GestureDetector(
          onTap: _expandReviews,
          child: addPadding(
              Text(
                _areReviewsExpanded ? 'Pokaż więcej...' : 'Pokaż mniej...',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              top: 8.0,
              bottom: 8.0),
        ),
      );

  void _expandReviews() {
    setState(() {
      _areReviewsExpanded = !_areReviewsExpanded;

      _refresReviewsCountToShow();

      _setReviewsState();
    });
  }

  void _refresReviewsCountToShow() {
    _reviewsCountToShow = _reviews.length > 0
        ? _reviews.length > 3
            ? _areReviewsExpanded ? 3 : _reviews.length
            : _reviews.length
        : 0;
  }

  void _callback() {
    setState(() {
      _refresReviewsCountToShow();
      _setReviewsState();
    });
  }

  void _setReviewsState() {
    _reviewsStateKey.currentState.setState(() {
      _reviewsStateKey.currentState.reviewsCountToShow = _reviewsCountToShow;
    });
  }
}
