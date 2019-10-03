import 'package:flutter/material.dart';
import 'package:template_name/shared/ui/cards/card_buttons_panel.dart';

class AdministratorPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          buildFullCardButtonsRow(['Menage users', 'Menage recipes'],
              [Icons.supervised_user_circle, Icons.receipt]),
          buildHalfCardButtonsRow('Menage applications', Icons.description)
        ])
      ]);
}
