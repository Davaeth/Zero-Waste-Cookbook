import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
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
        //margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        decoration: BoxDecoration(
          //borderRadius: new BorderRadius.all(const Radius.circular(8.0)),
          color: DefaultColors.backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            addPadding(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: <Widget>[
                    Text(
                      'User',
                      style: TextStyle(
                          color: RecipeColors.usernameColor, fontSize: 20.0),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child:Ratings(review.rate)),
                  ],
                ),
                bottom: 12.0),
            Text(
              review.description,
              style: TextStyle(color: RecipeColors.longTextColor),
              textAlign: TextAlign.justify,
            ),
            addPadding(
            Container(
                  height: 1.5,
                  color: DefaultColors.secondaryColor,
                  ),
                  top: 12.0),
          ],
        ),
      );
}
