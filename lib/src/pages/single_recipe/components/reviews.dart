import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/models/administration/review.dart';
import 'package:zero_waste_cookbook/ui/ratings.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/recipe_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

class Reviews extends StatefulWidget {
  final int reviewsCountToShow;
  final List<Review> reviews;

  Reviews({@required this.reviews, @required this.reviewsCountToShow, Key key})
      : super(key: key);

  @override
  ReviewsState createState() => ReviewsState();
}

class ReviewsState extends State<Reviews> {
  int reviewsCountToShow;

  List<Review> _reviews;

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: reviewsCountToShow,
        itemBuilder: (context, index) => _buildSingleReview(_reviews[index]),
      );

  @override
  void initState() {
    reviewsCountToShow = widget.reviewsCountToShow;

    _reviews = widget.reviews;

    super.initState();
  }

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
                      'User',
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
