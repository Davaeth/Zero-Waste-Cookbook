import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/search/filter_buttons.dart';
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
          body: ListView(shrinkWrap: true, children: <Widget>[
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Filters',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 24.0,
                                  color: DefaultColors.textColor),
                            ),
                          ],
                        ),
                        exitButton(context),
                      ],
                    ),
                  ),
                  Regions(),
                ])
          ]),
        ),
      );
}

class Regions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Regions',
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 18.0,
                color: DefaultColors.textColor),
          ),
        ),
        buildFilterButtonRow(['hi', 'hello']),
      ],
    );
  }
}
