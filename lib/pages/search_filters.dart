import 'package:flutter/material.dart';
import 'package:template_name/pages/slider_selector.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/enums/page.dart';
import 'package:template_name/shared/page_resolvers/navigator.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';
import 'package:template_name/pages/filter_buttons.dart';

class Filters extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
           Padding(
          padding: const EdgeInsets.all(8.0),
          child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 24.0, color: DefaultColors.textColor),
              ),
                ],
              ),
              Row(
                    children: <Widget>[
                      Container(
                        color: DefaultColors.backgroundColor,
                        child:
                      Material(
                        child:
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: (){
                      Navigator.pop(context);
                    },
              ),
                      ),
                      ),
            ],
              ),
              
            ],
            
          ),
          
        ),
         Regions(),           
        ])
      ]);
}

class Regions extends StatelessWidget {
  const Regions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
        Text('Regions',
        style: TextStyle(
        fontSize: 18.0, color: DefaultColors.textColor),),
        ),
        buildFilterButtonRow(['hi', 'hello']),
      ],
    );
  }
}

class PrepTimeSlider extends StatelessWidget {
  const PrepTimeSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
        Text('Regions',
        style: TextStyle(
        fontSize: 18.0, color: DefaultColors.textColor),),
        )
      ],
    );
  }
}