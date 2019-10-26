import 'package:flutter/material.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';
import 'package:template_name/shared/colors/default_colors.dart';

Padding buildUserInfoIcon(String amount, IconData iconData) =>
    addPadding(
        Container(
          padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(4.0),
                    child:
                  Icon(
                    iconData,
                  color: DefaultColors.iconColor
                  ),
                  ),
                  Text(
                    amount,
                    style: TextStyle(
                  fontSize: 18.0, color: Colors.white),
                  )
              ],
            ),
          ),
top: 8.0,
bottom: 8.0,
);

Column buildUserInfo(List<String> amounts, List<IconData> iconsData, String username) =>
    Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            addPadding(
          CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage('https://pbs.twimg.com/media/DZT8l1jWkAI6KFS.jpg'),
                ),
            top:16.0,
            bottom: 16.0),
                ]
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
          Text(
                username,
                style: TextStyle(
                  fontSize: 24.0, color: Colors.white),
              ),
      ]
        ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            buildUserInfoIcon(amounts.first, iconsData.first),
            buildUserInfoIcon(amounts.first, iconsData.last),
            buildUserInfoIcon(amounts.last, iconsData.last),
          ],
        )
      ],
    );
