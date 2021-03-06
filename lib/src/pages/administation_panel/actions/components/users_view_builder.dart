import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/administration/user.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/components/models/administrator_action.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

class UsersViewBuilder extends StatefulWidget {
  @override
  _UsersViewBuilderState createState() => _UsersViewBuilderState();
}

class _UsersViewBuilderState extends State<UsersViewBuilder> {
  List<User> _users;

  AdministratorAction _administratorAction;

  @override
  Widget build(BuildContext context) {
    var _dbService = DatabaseService();

    return Scaffold(
      backgroundColor: DefaultColors.backgroundColor,
      body: SafeArea(
        top: true,
        bottom: true,
        child: ListView(
          children: <Widget>[
            _buildMainRow(_dbService, context),
            _buildUsersList(_dbService),
          ],
        ),
      ),
    );
  }

  CircleAvatar buildCircleAvatar(int index) => CircleAvatar(
        radius: 50.0,
        backgroundImage: NetworkImage(
          _users[index].account['avatarUrl'],
        ),
      );

  @override
  void initState() {
    _users = List<User>();
    _administratorAction = AdministratorAction();

    super.initState();
  }

  Column _buildAnInterior(int index) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildCircleAvatar(index),
          Text(
            _users[index].account['username'],
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          )
        ],
      );

  Align _buildCloseButton(BuildContext context) => Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(Icons.close),
          color: DefaultColors.iconColor,
          iconSize: 35.0,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            stepPageBack(context);
          },
        ),
      );

  Row _buildMainRow(DatabaseService dbService, BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _administratorAction.areReadyToDelete
              ? IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  iconSize: 35.0,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => _deleteUsers(dbService),
                )
              : Icon(null),
          _buildCloseButton(context),
        ],
      );

  Padding _buildSingleCard(int index) => addPadding(
        GestureDetector(
          onLongPress: () =>
              _administratorAction.multipleSelect(index, _callback),
          child: Card(
            color: DefaultColors.backgroundColor,
            child: _buildAnInterior(index),
          ),
        ),
        bottom: 8.0,
      );

  FutureBuilder<QuerySnapshot> _buildUsersList(DatabaseService _dbService) =>
      FutureBuilder<QuerySnapshot>(
        future: _dbService.getAllData('Users'),
        builder: (context, AsyncSnapshot<QuerySnapshot> userSnapshots) {
          if (userSnapshots.hasData) {
            _getUsers(userSnapshots);

            return GridView.builder(
              shrinkWrap: true,
              controller: ScrollController(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: _users.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildSingleCard(index),
            );
          } else {
            return ListView();
          }
        },
      );

  void _callback() {
    setState(() {});
  }

  Future<void> _deleteUsers(DatabaseService dbService) async {
    setState(() async {
      for (var index in _administratorAction.getIndexes) {
        dbService.deleteDatum('Users', _users[index].id);

        var _user = await FirebaseAuth.instance.currentUser();

        _user.delete();

        var recipesSnapshots =
            await dbService.getDataByField('Recipes', 'user', _users[index].id);

        for (var recipeSnapshot in recipesSnapshots) {
          dbService.deleteDatum('Recipes', recipeSnapshot.documentID);
          dbService.deleteDataByRelation(
              'Tags', 'recipe', 'Recipes', recipeSnapshot.documentID);
          dbService.deleteDataByRelation(
              'Reviews', 'recipe', 'Recipes', recipeSnapshot.documentID);
        }
      }

      _administratorAction.setIndexes = List<int>();
      _administratorAction.setReadyToDelete = false;
    });
  }

  Future<void> _getUsers(AsyncSnapshot<QuerySnapshot> userSnapshots) async {
    _users = List<User>();

    userSnapshots.data.documents.forEach(
      (userSnapshot) => _users.add(User.fromFirestore(userSnapshot)),
    );
  }
}
