import 'package:flutter/material.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/pages/search/filter_buttons.dart';
import 'package:template_name/shared/page_resolvers/navigator.dart';
import 'package:template_name/shared/ui/user_profile/user_button.dart';
import 'package:template_name/pages/language_dropdown.dart';

class Settings extends StatelessWidget {
   @override
  Widget build(BuildContext context) => SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          backgroundColor: DefaultColors.backgroundColor,
          body: ListView(
            shrinkWrap: true,
            children: <Widget>[
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
                      'Settings',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 24.0, color: DefaultColors.textColor),
              ),
                ],
              ),
              exitButton(context),              
            ],
          ),
        ),  
        LanguageDropdown(),
        deleteAccountButton(context),
        logoutButton(context),
        ])
      ]
      ),
        ),
  );
}
