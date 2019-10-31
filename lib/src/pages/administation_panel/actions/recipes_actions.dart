import 'package:flutter/material.dart';

import 'components/actions_view_builder.dart';
import 'models/administrator_action.dart';

class RecipesActions extends StatefulWidget {
  @override
  _RecipesActionsState createState() => _RecipesActionsState();
}

class _RecipesActionsState extends State<RecipesActions> {
  List<AdministratorAction> _users = [
    AdministratorAction("elo"),
    AdministratorAction("test 2")
  ];

  @override
  Widget build(BuildContext context) => ActionsViewBuilder(_users);
}
