import 'package:flutter/material.dart';

import 'components/actions_view_builder.dart';
import 'models/administrator_action.dart';

class ApplicationsActions extends StatefulWidget {
  @override
  _ApplicationsActionsState createState() => _ApplicationsActionsState();
}

class _ApplicationsActionsState extends State<ApplicationsActions> {
  List<AdministratorAction> _users = [
    AdministratorAction("elo"),
    AdministratorAction("test 2")
  ];

  @override
  Widget build(BuildContext context) => ActionsViewBuilder(_users);
}
