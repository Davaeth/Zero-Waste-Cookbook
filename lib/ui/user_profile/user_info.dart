import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

Padding buildUserInfoIcon(String amount, IconData iconData) => addPadding(
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Icon(iconData, color: DefaultColors.iconColor),
            SizedBox(
              width: 6.0,
            ),
            Text(
              amount,
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            )
          ],
        ),
      ),
      top: 8.0,
      bottom: 8.0,
    );

Column buildUserInfo(List<String> amounts, List<IconData> iconsData,
        String username, String imageUrl) =>
    Column(
      children: <Widget>[
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              addPadding(
                  CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        imageUrl,
                      )),
                  top: 16.0,
                  bottom: 16.0),
            ]),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
                username,
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ]),
          ],
        )
      ],
    );
