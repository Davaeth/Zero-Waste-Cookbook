import 'package:flutter/material.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/pages/search/search_filters.dart';
import 'package:template_name/pages/search/popular_categories_cards.dart';
import 'package:template_name/pages/search/search_widget.dart';
import 'package:template_name/shared/page_resolvers/navigator.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, 
        children: <Widget>[
           searchWidget(),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: MaterialButton(
                    child: Text('Filters'),
                    textColor: DefaultColors.iconColor,
                    onPressed: (){
                      navigateToPageByNumber(3, context);},
                  ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0,16.0,8.0),
              child: 
              Text(
                'Popular categories',
                style: TextStyle(
                  fontSize: 24.0, color: DefaultColors.textColor),
              ),
            ),
          buildFullCardPopularRow(['Fast food','Borgers'], [Image.asset('assets/images/borger.jpg'),Image.asset('assets/images/borger.jpg'),]),
        ])
      ]);
}

