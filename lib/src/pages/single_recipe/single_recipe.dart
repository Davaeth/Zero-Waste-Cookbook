import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/administration/review.dart';
import 'package:zero_waste_cookbook/src/models/food/ingredient.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/pages/single_recipe/components/review_creator.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card.dart';
import 'package:zero_waste_cookbook/ui/expansion_tiles/expansion_tile_builder.dart';
import 'package:zero_waste_cookbook/ui/expansion_tiles/section.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

import 'components/reviews.dart';

class SingleRecipe extends StatefulWidget {
  final String recipeID;

  SingleRecipe({@required this.recipeID});

  @override
  State<StatefulWidget> createState() => _SingleRecipeState();
}

class _SingleRecipeState extends State<SingleRecipe>
    with AfterLayoutMixin<SingleRecipe> {
  int _reviewsCountToShow = 0;
  bool _areReviewsExpanded = false;
  bool _isPageBuilt = false;

  GlobalKey<ReviewsState> _reviewsStateKey = GlobalKey<ReviewsState>();

  DatabaseService _databaseService;

  List<Review> _reviews;
  String _recipeID;

  Recipe _this;

  @override
  void afterFirstLayout(BuildContext context) async {
    _expandReviews();
    _isPageBuilt = true;
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          backgroundColor: DefaultColors.backgroundColor,
          body: FutureBuilder(
            future: _databaseService.getDatumByID('Recipes', _recipeID),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              _getRecipeData(snapshot);

              return ListView(
                shrinkWrap: true,
                children: <Widget>[
                  RecipeCard(
                    interior: RecipeCard.createInteriorForCardWithRating(
                      imagePath: 'assets/images/small-food.png',
                      recipe: _this,
                      userId: 'MtcBAWcygoW6ERK83agC',
                      context: context,
                    ),
                    isTappable: false,
                  ),
                  FutureBuilder(
                    future: _databaseService
                        .getRecipeIngredients(_this.ingredients),
                    builder: (context,
                        AsyncSnapshot<List<DocumentSnapshot>> snapshots) {
                      var ingredientsNames = _extractIngredients(snapshots);

                      return addPadding(
                          ExpansionTileBuilder(
                            Section(
                              'INGREDIENTS',
                              entries: ingredientsNames.toList(),
                            ),
                          ),
                          top: 4.0,
                          bottom: 8.0);
                    },
                  ),
                  addPadding(
                      ExpansionTileBuilder(
                        Section(
                          'DESCRIPTION',
                          entries: [_this.description],
                        ),
                      ),
                      bottom: 8.0),
                  ReviewCreator(_callback, _recipeID),
                  StreamBuilder(
                    stream: _databaseService.getRecipeReviews(_recipeID),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> snapshots) =>
                            _buildReviewsList(snapshots),
                  ),
                  _createReviewExpandText()
                ],
              );
            },
          ),
        ),
      );

  @override
  void initState() {
    _databaseService = DatabaseService();

    _recipeID = widget.recipeID;
    _reviews = List<Review>();

    super.initState();
  }

  Reviews _buildReviewsList(AsyncSnapshot<QuerySnapshot> asyncSnapshots) {
    _reviews = List<Review>();

    for (var review in asyncSnapshots.data.documents) {
      _reviews.add(Review.fromFirestore(review));
    }

    if (_isPageBuilt) {
      setState(() {
        _refresReviewsCountToShow();
      });
    } else {
      _refresReviewsCountToShow();
    }

    return Reviews(
      reviews: _reviews,
      reviewsCountToShow: _reviewsCountToShow,
      key: _reviewsStateKey,
    );
  }

  void _callback() {
    setState(() {
      _refresReviewsCountToShow();
      _setReviewsState();
    });
  }

  Center _createReviewExpandText() => Center(
        child: GestureDetector(
          onTap: _expandReviews,
          child: addPadding(
              Text(
                _areReviewsExpanded ? 'Pokaż mniej...' : 'Pokaż więcej...',
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

  Iterable<String> _extractIngredients(
      AsyncSnapshot<List<DocumentSnapshot>> snapshots) sync* {
    for (var snapshot in snapshots.data) {
      yield Ingredient.fromFirestore(snapshot).ingredientName;
    }
  }

  void _getRecipeData(AsyncSnapshot<DocumentSnapshot> snapshot) {
    _this = Recipe.fromFirestore(snapshot.data);
  }

  void _refresReviewsCountToShow() {
    _reviewsCountToShow = _reviews.length > 0
        ? _reviews.length > 3
            ? _areReviewsExpanded ? 3 : _reviews.length
            : _reviews.length
        : 0;
  }

  void _setReviewsState() {
    _reviewsStateKey.currentState.setState(() {
      _reviewsStateKey.currentState.reviewsCountToShow = _reviewsCountToShow;
    });
  }
}
