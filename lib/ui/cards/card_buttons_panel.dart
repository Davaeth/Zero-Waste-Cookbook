import 'package:flutter/material.dart';
import 'package:template_name/ui/shared/page_resolvers/navigator.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';

GestureDetector buildAdministratorCardButton(
        String text, IconData iconData, String route, BuildContext context) =>
    switchPage(
        context,
        addPadding(
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    iconData,
                    size: 120.0,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ),
            ),
            bottom: 4.0,
            right: 4.0),
        route);
