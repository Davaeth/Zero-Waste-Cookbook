import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/administration/review.dart';
import 'package:zero_waste_cookbook/src/models/administration/user.dart';
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

  DatabaseService _dbService;

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

    _dbService = DatabaseService();

    super.initState();
  }

  Column _buildMainColumn(Review review) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          addPadding(
            _buildMainRow(review),
            bottom: 12.0,
          ),
          _buildReviewDescription(review),
        ],
      );

  Row _buildMainRow(Review review) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FutureBuilder<User>(
          future: _dbService.getReviewAtuhor(review),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var _author = snapshot.data;

              return Text(
                _author.account['username'],
                style: TextStyle(
                    color: RecipeColors.usernameColor, fontSize: 18.0),
              );
            } else {
              return Text('');
            }
          },
        ),
        _buildReviewDeleteButton(_dbService, review),
        Align(
          alignment: Alignment.topCenter,
          child: Ratings(review.rate),
        ),
      ],
    );
  }

  FutureBuilder<bool> _buildReviewDeleteButton(
          DatabaseService _dbService, Review review) =>
      FutureBuilder<bool>(
        future:
            _dbService.checkIfUserIsAReviewCreator(currentUserId, review.id),
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
      );

  Text _buildReviewDescription(Review review) => Text(
        review.description,
        maxLines: null,
        style: TextStyle(color: RecipeColors.longTextColor),
        textAlign: TextAlign.justify,
      );

  Container _buildSingleReview(Review review) => Container(
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        decoration: BoxDecoration(
          color: DefaultColors.backgroundColor,
        ),
        child: _buildMainColumn(review),
      );

  void _deleteReview(DatabaseService _dbService, Review review) {
    setState(() {
      _dbService.deleteDatum('Reviews', review.id);

      _dbService.updateRecipeRank(_recipeId);

      _singleRecipeCallback();
    });
  }
}
