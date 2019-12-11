import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

GestureDetector buildAdministratorCardButton(
        String text, IconData iconData, String route, BuildContext context) =>
    switchPage(
        context,
        addPadding(
          Card(
            color: DefaultColors.secondaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconData,
                  size: 160.0,
                  color: Colors.white,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: DefaultColors.iconColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          right: 2.0,
          left: 2.0,
        ),
        route);
