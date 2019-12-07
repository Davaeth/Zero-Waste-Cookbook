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

class _SingleRecipeState extends State<SingleRecipe> {
  int _reviewsCountToShow = 0;
  bool _isPageBuilt = false;
  bool _areReviewsExpanded;
  bool _isFav;

  GlobalKey<ReviewsState> _reviewsStateKey = GlobalKey<ReviewsState>();

  DatabaseService _databaseService;

  List<Review> _reviews;
  String _recipeID;

  Recipe _this;

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
              if (snapshot.hasData) {
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
                        isFav: _isFav,
                        callback: (bool isFav) =>
                            _recipeStackCardCallback(isFav),
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
                    ReviewCreator(_reviewsCallback, _recipeID),
                    StreamBuilder(
                      stream: _databaseService.getRecipeReviews(_recipeID),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                        if (snapshot.hasData) {
                          _buildReviewsList(snapshots);

                          return Reviews(
                            reviews: _reviews,
                            reviewsCountToShow: _reviewsCountToShow,
                            key: _reviewsStateKey,
                          );
                        } else {
                          return ListView();
                        }
                      },
                    ),
                    _createReviewExpandText()
                  ],
                );
              } else {
                return ListView();
              }
            },
          ),
        ),
      );

  @override
  void initState() {
    _databaseService = DatabaseService();

    _recipeID = widget.recipeID;
    _reviews = List<Review>();

    _areReviewsExpanded = false;
    _isFav = false;

    super.initState();
  }

  _buildReviewsList(AsyncSnapshot<QuerySnapshot> asyncSnapshots) {
    _reviews = List<Review>();

    for (var review in asyncSnapshots.data.documents) {
      _reviews.add(Review.fromFirestore(review));
    }

    _refreshReviewsCountToShow();
  }

  Center _createReviewExpandText() => Center(
        child: GestureDetector(
          onTap: () => _expandReviews(),
          child: addPadding(
              Text(
                _areReviewsExpanded ? 'Show less...' : 'Show more...',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
              top: 8.0,
              bottom: 8.0),
        ),
      );

  void _expandReviews() {
    setState(() {
      _areReviewsExpanded = !_areReviewsExpanded;

      _refreshReviewsCountToShow();

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

  _recipeStackCardCallback(bool isFav) {
    setState(() {
      _isFav = isFav;
    });
  }

  void _refreshReviewsCountToShow() {
    _reviewsCountToShow = _areReviewsExpanded ? _reviews.length : 3;

    if (_areReviewsExpanded) {
      _reviewsCountToShow = _reviews.length;
      return;
    }

    if (_reviews.length > 3) {
      _reviewsCountToShow = 3;
    } else {
      _reviewsCountToShow = _reviews.length;
    }
  }

  void _reviewsCallback() {
    setState(() {
      _refreshReviewsCountToShow();
      _setReviewsState();
    });
  }

  void _setReviewsState() {
    _reviewsStateKey.currentState.setState(() {
      _reviewsStateKey.currentState.reviewsCountToShow = _reviewsCountToShow;
      _reviewsStateKey.currentState.reviews = _reviews;
    });
  }
}
