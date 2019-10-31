import 'package:flutter/material.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';



Padding searchWidget() => addPadding(
        Container(
          padding: const EdgeInsets.all(8.0),
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
            );