import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/administration/review.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';
import 'package:zero_waste_cookbook/ui/ratings.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/recipe_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

class Reviews extends StatefulWidget {
  final int reviewsCountToShow;
  final List<Review> reviews;
  final Function singleRecipeCallback;
  final String recipeId;

  Reviews(
      {@required this.reviews,
      @required this.reviewsCountToShow,
      @required this.singleRecipeCallback,
      @required this.recipeId,
      Key key})
      : super(key: key);

  @override
  ReviewsState createState() => ReviewsState();
}

class ReviewsState extends State<Reviews> {
  int reviewsCountToShow;

  List<Review> reviews;

  Function _singleRecipeCallback;

  String _recipeId;

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: reviewsCountToShow,
        itemBuilder: (context, index) => _buildSingleReview(reviews[index]),
      );

  @override
  void initState() {
    reviewsCountToShow = widget.reviewsCountToShow;

    reviews = widget.reviews;

    _singleRecipeCallback = widget.singleRecipeCallback;

    _recipeId = widget.recipeId;

    super.initState();
  }

  Column _buildMainColumn(Review review) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          addPadding(_buildMainRow(review), bottom: 12.0),
          _buildSecondaryRow(review),
        ],
      );

  Row _buildMainRow(Review review) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Zweryfikowany użytkownik',
            style: TextStyle(color: RecipeColors.usernameColor, fontSize: 18.0),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Ratings(review.rate),
          ),
        ],
      );

  Row _buildSecondaryRow(Review review) {
    var _dbService = DatabaseService();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          review.description,
          style: TextStyle(color: RecipeColors.longTextColor),
          textAlign: TextAlign.justify,
        ),
        FutureBuilder<bool>(
          future: _dbService.checkIfUserIsAReviewCreator(
              fUserId, review.id),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data
                  ? IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => _deleteReview(_dbService, review),
                    )
                  : Icon(null, size: 0);
            } else {
              return Icon(null, size: 0);
            }
          },
        ),
      ],
    );
  }

  void _deleteReview(DatabaseService _dbService, Review review) {
    setState(() {
      _dbService.deleteDatum('Reviews', review.id);

      _dbService.updateRecipeRank(_recipeId);

      _singleRecipeCallback();
    });
  }

  Container _buildSingleReview(Review review) => Container(
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        decoration: BoxDecoration(
          color: DefaultColors.backgroundColor,
        ),
        child: _buildMainColumn(review),
      );
}
