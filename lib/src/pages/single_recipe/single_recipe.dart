import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/administration/review.dart';
import 'package:zero_waste_cookbook/src/models/food/ingredient.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/pages/single_recipe/components/review_creator.dart';
import 'package:zero_waste_cookbook/utils/routes_arguments.dart';
import 'package:zero_waste_cookbook/ui/cards/recipe_card.dart';
import 'package:zero_waste_cookbook/ui/constants/routes.dart';
import 'package:zero_waste_cookbook/ui/expansion_tiles/expansion_tile_builder.dart';
import 'package:zero_waste_cookbook/ui/expansion_tiles/section.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

import 'components/reviews.dart';

class SingleRecipe extends StatefulWidget {
  final String recipeID;

  SingleRecipe({@required this.recipeID});

  @override
  State<StatefulWidget> createState() => _SingleRecipeState();
}

class _SingleRecipeState extends State<SingleRecipe> {
  int _reviewsCountToShow = 0;
  bool _areReviewsExpanded;
  bool _isFav;

  GlobalKey<ReviewsState> _reviewsStateKey = GlobalKey<ReviewsState>();

  DatabaseService _databaseService;

  List<Review> _reviews;
  String _recipeID;

  Recipe _recipe;

  @override
  Widget build(BuildContext context) => SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          backgroundColor: DefaultColors.backgroundColor,
          body: _buildSingleRecipe(),
        ),
      );

  FutureBuilder<DocumentSnapshot> _buildSingleRecipe() => FutureBuilder(
        future: _databaseService.getDatumByID('Recipes', _recipeID),
        builder: (context, AsyncSnapshot<DocumentSnapshot> recipeSnapshot) {
          if (recipeSnapshot.hasData) {
            _getRecipeData(recipeSnapshot);

            return ListView(
              shrinkWrap: true,
              children: <Widget>[
                RecipeCard(
                  interior: RecipeCard.createInteriorForCardWithRating(
                    recipe: _recipe,
                    userId: currentUserId,
                    context: context,
                    iconData: _isFav ? Icons.favorite : Icons.favorite_border,
                    callback: (bool isFav) => _recipeStackCardCallback(isFav),
                  ),
                  isTappable: false,
                  recipeID: _recipe.id,
                ),
                _buildIngredients(),
                addPadding(
                  ExpansionTileBuilder(
                    Section(
                      Translator.instance.translations['description']
                          .toUpperCase(),
                      entries: [_recipe.description],
                    ),
                  ),
                  bottom: 8.0,
                ),
                ReviewCreator(_reviewsCallback, _recipeID),
                _buildReviews(),
                _createReviewExpandText()
              ],
            );
          } else {
            return ListView();
          }
        },
      );

  FutureBuilder<List<DocumentSnapshot>> _buildIngredients() => FutureBuilder(
        future: _databaseService.getRecipeIngredients(_recipe.ingredients),
        builder: (
          context,
          AsyncSnapshot<List<DocumentSnapshot>> ingredientsSnapshots,
        ) {
          if (ingredientsSnapshots.hasData) {
            var ingredientsNames = _extractIngredients(ingredientsSnapshots);

            ingredientsNames.forEach((ingredientName) => ingredientName =
                Translator.instance.translations['ingredients_list']
                    [ingredientName]);

            return addPadding(
              ExpansionTileBuilder(
                Section(
                  Translator.instance.translations['ingredients'].toUpperCase(),
                  entries: ingredientsNames.toList(),
                ),
              ),
              top: 4.0,
              bottom: 8.0,
            );
          } else {
            return Text('Błąd');
          }
        },
      );

  StreamBuilder<QuerySnapshot> _buildReviews() => StreamBuilder(
        stream: _databaseService.getRecipeReviews(_recipeID),
        builder: (context, AsyncSnapshot<QuerySnapshot> reviewsSnapshots) {
          if (reviewsSnapshots.hasData) {
            _buildReviewsList(reviewsSnapshots);

            return Reviews(
              reviews: _reviews,
              reviewsCountToShow: _reviewsCountToShow,
              key: _reviewsStateKey,
              singleRecipeCallback: _addReviewCallback,
              recipeId: _recipeID,
            );
          } else {
            return ListView();
          }
        },
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
              _areReviewsExpanded
                  ? Translator.instance.translations['show_less']
                  : Translator.instance.translations['show_more'],
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
            top: 8.0,
            bottom: 8.0,
          ),
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
      yield Ingredient.fromFirestore(snapshot).name;
    }
  }

  void _getRecipeData(AsyncSnapshot<DocumentSnapshot> snapshot) {
    _recipe = Recipe.fromFirestore(snapshot.data);
  }

  _recipeStackCardCallback(bool isFav) {
    setState(() {
      _isFav = isFav;
    });
  }

  void _refreshReviewsCountToShow() {
    if (_areReviewsExpanded) {
      _reviewsCountToShow = _reviews.length;
    } else {
      if (_reviews.length <= 3) {
        _reviewsCountToShow = _reviews.length;
      } else {
        _reviewsCountToShow = 3;
      }
    }
  }

  void _reviewsCallback() {
    _setReviewsState();
    _refreshReviewsCountToShow();
  }

  void _addReviewCallback() {
    Navigator.pushReplacementNamed(context, Routes.Recipe,
        arguments: RoutesArguments(_recipeID, null));
  }

  void _setReviewsState() {
    _reviewsStateKey.currentState.setState(() {
      _reviewsStateKey.currentState.reviewsCountToShow = _reviewsCountToShow;
      _reviewsStateKey.currentState.reviews = _reviews;
    });
  }
}
