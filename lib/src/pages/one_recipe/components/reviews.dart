import 'package:flutter/material.dart';
import 'package:template_name/src/models/review.dart';
import 'package:template_name/src/models/user.dart';
import 'package:template_name/ui/ratings.dart';
import 'package:template_name/ui/shared/colors/recipe_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';

class Reviews extends StatefulWidget {
  final User _user;
  final List<Review> _reviews;
  final int _reviewsCountToShow;

  final Icon icon;

  Reviews(this._user, this._reviews, this._reviewsCountToShow,
      {this.icon, Key key})
      : super(key: key);

  @override
  ReviewsState createState() => ReviewsState();
}

class ReviewsState extends State<Reviews> {
  User _user;
  List<Review> _reviews;
  int reviewsCountToShow;

  Icon icon;

  @override
  void initState() {
    _user = widget._user;
    _reviews = widget._reviews;
    reviewsCountToShow = widget._reviewsCountToShow;

    super.initState();
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: reviewsCountToShow,
        itemBuilder: (context, index) => _buildSingleReview(_reviews[index]),
      );

  Container _buildSingleReview(Review review) => Container(
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: RecipeColors.bordercolor)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            addPadding(
                Row(
                  children: <Widget>[
                    Text(
                      review.user.username,
                      style: TextStyle(
                          color: RecipeColors.usernameColor, fontSize: 25.0),
                    ),
                    addPadding(Ratings(review.rate), left: 8.0),
                  ],
                ),
                bottom: 8.0),
            Text(
              review.description,
              style: TextStyle(color: RecipeColors.longTextColor),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      );
}
