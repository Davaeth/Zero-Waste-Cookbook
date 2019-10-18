import 'package:flutter/material.dart';

import 'components/actions_view_builder.dart';
import 'models/administrator_action.dart';

class UsersActions extends StatefulWidget {
  @override
  _UsersActionsState createState() => _UsersActionsState();
}

class _UsersActionsState extends State<UsersActions> {
  List<AdministratorAction> _users = [
    AdministratorAction("elo"),
    AdministratorAction("test 2")
  ];

  @override
  Widget build(BuildContext context) => ActionsViewBuilder(_users);
}
