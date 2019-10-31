import 'package:flutter/material.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/user_profile/language_dropdown.dart';
import 'package:template_name/ui/user_profile/user_button.dart';

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
