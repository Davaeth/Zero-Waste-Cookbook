import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/pages/search/filter_list.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/user_profile/user_button.dart';

class Filters extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          backgroundColor: DefaultColors.backgroundColor,
          body: ListView(
            children: <Widget>[
              _buildTopRow(context),
              FiltersList(collection: 'Regions'),
              FiltersList(collection: 'Ingredients'),
            ],
          ),
        ),
      );

  Padding _buildTopRow(BuildContext context) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Filters',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 24.0,
                color: DefaultColors.iconColor,
              ),
            ),
            exitButton(context),
          ],
        ),
      );
}
