import 'package:flutter/material.dart';
import 'package:template_name/ui/ratings.dart';
import 'package:template_name/ui/shared/colors/recipe_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';

class Reviews extends StatelessWidget {
  final String _username;
  final int _ratingValue;
  final Icon icon;

  Reviews(this._username, this._ratingValue, {this.icon});

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: RecipeColors.bordercolor)),
        ),
        child: Column(
          children: <Widget>[
            addPadding(
                Row(
                  children: <Widget>[
                    Text(
                      _username,
                      style: TextStyle(
                          color: RecipeColors.usernameColor, fontSize: 25.0),
                    ),
                    addPadding(Ratings(), left: 8.0),
                  ],
                ),
                bottom: 8.0),
            Text(
              'Curabitur id ultricies sapien. Maecenas ultrices, mauris eu dapibus auctor, odio lectus condimentum dolor, nec hendrerit ex risus quis ipsum. Nulla massa lacus, faucibus nec velit id, fermentum posuere odio. Phasellus sapien arcu, sodales nec consectetur nec, congue et risus. Donec auctor aliquet augue ac cursus. Vestibulum erat odio, euismod dapibus sapien non, sagittis tincidunt neque. Nulla nec fermentum urna, a mollis velit. Quisque consequat tincidunt nunc a porta. Etiam dignissim dolor a dolor fermentum, a bibendum ex porttitor. Donec malesuada accumsan elit a luctus. Interdum et malesuada fames ac ante ipsum primis in faucibus. Maecenas at dui ex. Nullam egestas tempor ligula, vitae feugiat ante pellentesque eget.',
              style: TextStyle(color: RecipeColors.longTextColor),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      );
}
