import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/ui/constants/enums/routes.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

Widget buildUserButtons(
    BuildContext context, String buttonName, String pageNumber) {
  return new FlatButton(
    child: Text(buttonName),
    color: DefaultColors.iconColor,
    textColor: DefaultColors.textColor,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(18.0),
      side: BorderSide(color: DefaultColors.iconColor),
    ),
    onPressed: () {
      navigateToPageByRoute(pageNumber, context);
    },
  );
}

Row buildUserButtonsRow(
        context, List<String> buttonNamesList, List<String> pageNumberList) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        buildUserButtons(context, buttonNamesList.first, pageNumberList.first),
        SizedBox(
          width: 8.0,
        ),
        buildUserButtons(context, buttonNamesList.last, pageNumberList.last),
      ],
    );

Row deleteAccountButton(BuildContext context) => Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(0),
          child: Text(
            Translator.instance.translations['delete_account'],
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () async { await _deleteUser();signOutGoogle();navigateToPageByRoute(Routes.LoginPage, context);
           }
        )
      ],
    );

Row exitButton(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
            icon: new Icon(Icons.close),
            color: DefaultColors.disabledIconColor,
            onPressed: () {
              stepPageBack(context);
            }),
      ],
    );

Row logoutButton(BuildContext context) => Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          Translator.instance.translations['logout'],
          style: TextStyle(color: DefaultColors.textColor),
        ),
        IconButton(
            icon: new Icon(Icons.exit_to_app),
            color: DefaultColors.disabledIconColor,
            onPressed: () {
              signOutGoogle();
              navigateToPageByRoute(Routes.LoginPage, context);
            }),
      ],
    );

Row settingsButton(BuildContext context, int pageNumber) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
            icon: new Icon(Icons.settings),
            padding: new EdgeInsets.only(top: 8.0, right: 16.0),
            color: DefaultColors.disabledIconColor,
            onPressed: () {
              navigateToPageByRoute(Routes.SettingsPage, context);
            }),
      ],
    );

Future _deleteUser() async {
  var _dbService = DatabaseService();

  _dbService.deleteDatum('Users', currentUserId);

  var _user = await FirebaseAuth.instance.currentUser();

  _user.delete();

  var recipesSnapshots =
      await _dbService.getDataByField('Recipes', 'user', currentUserId);

  for (var recipeSnapshot in recipesSnapshots) {
    _dbService.deleteDatum('Recipes', recipeSnapshot.documentID);
    _dbService.deleteDataByRelation(
        'Tags', 'recipe', 'Recipes', recipeSnapshot.documentID);
    _dbService.deleteDataByRelation(
        'Reviews', 'recipe', 'Recipes', recipeSnapshot.documentID);
  }
}
