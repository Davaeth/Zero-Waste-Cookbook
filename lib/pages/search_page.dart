import 'package:flutter/material.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/ui/cards/card_buttons_panel.dart';
import 'package:template_name/pages/search_filters.dart';
import 'package:template_name/pages/slider_selector.dart';
import 'package:template_name/pages/popular_categories_cards.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, 
        children: <Widget>[
           Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: TextField(
                cursorColor: DefaultColors.iconColor,
                style: TextStyle(color: DefaultColors.textColor, height: 0.8),
                onChanged: (value) {},
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: DefaultColors.disabledIconColor),
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search,
                    color: DefaultColors.iconColor),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: DefaultColors.disabledIconColor),),
                        focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: DefaultColors.iconColor),)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: MaterialButton(
                    child: Text('Filters'),
                    textColor: DefaultColors.iconColor,
                    onPressed: (){
                      Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Filters()),
            );
                    },
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

