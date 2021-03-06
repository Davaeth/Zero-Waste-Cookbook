import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/cards/card_buttons_panel.dart';
import 'package:zero_waste_cookbook/ui/constants/enums/routes.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

class AdministratorPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        left: true,
        right: true,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildElement(
                Translator.instance.translations['manage_users'],
                Icons.supervised_user_circle,
                Routes.AdministratorUsers,
                context),
            _buildElement(Translator.instance.translations['manage_recipes'],
                Icons.receipt, Routes.AdministratorRecipes, context),
          ],
        ),
      );

  Container _buildElement(
          String text, IconData icon, String route, BuildContext context) =>
      Container(
        height: (MediaQuery.of(context).size.height / 100) * 35,
        width: (MediaQuery.of(context).size.width / 100) * 50,
        child: buildAdministratorCardButton(text, icon, route, context),
      );
}
