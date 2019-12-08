import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/cards/card_buttons_panel.dart';
import 'package:zero_waste_cookbook/ui/constants/routes.dart';

class AdministratorPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        padding: EdgeInsets.only(left: 8.0, right: 4.0, top: 8.0, bottom: 4.0),
        children: <Widget>[
          buildAdministratorCardButton("Manage users",
              Icons.supervised_user_circle, Routes.AdministratorUsers, context),
          buildAdministratorCardButton("Manage recipes", Icons.receipt,
              Routes.AdministratorRecipes, context),
          buildAdministratorCardButton("Manage applications", Icons.description,
              Routes.AdministratorApplications, context),
        ],
      );
}
