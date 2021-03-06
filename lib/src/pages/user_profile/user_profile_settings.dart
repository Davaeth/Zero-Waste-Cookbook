import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/user_profile/language_dropdown.dart';
import 'package:zero_waste_cookbook/ui/user_profile/user_button.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

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
                              Translator.instance.translations['settings'],
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
                  LanguageDropdown(),
                  deleteAccountButton(context),
                  logoutButton(context),
                ],
              )
            ],
          ),
        ),
      );
}
