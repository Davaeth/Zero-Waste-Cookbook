import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template_name/ui/constants/routes.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/navigator.dart';

Widget buildUserButtons(BuildContext context, String buttonName, String pageNumber) {
   return new FlatButton(
                    child: Text(buttonName),
                    color: DefaultColors.iconColor,
                    textColor: DefaultColors.textColor,
                    shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color:DefaultColors.iconColor),
                    ),
                    onPressed: (){navigateToPageByRoute(pageNumber, context);},
          );
}

Row buildUserButtonsRow(context, List<String> buttonNamesList, List<String> pageNumberList) =>
Row(
  mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
   children: <Widget>[
      buildUserButtons(context, buttonNamesList.first, pageNumberList.first),
      SizedBox(width: 8.0,),
      buildUserButtons(context, buttonNamesList.last, pageNumberList.last),
   ]
);

Row settingsButton(BuildContext context, int pageNumber) =>
Row (
  mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
  children: <Widget>[
    IconButton(
      icon: new Icon(Icons.settings), padding: new EdgeInsets.only(top: 8.0, right: 16.0), color: DefaultColors.disabledIconColor, onPressed: (){navigateToPageByRoute(Routes.SettingsPage, context);}
          ),
        ],
);

Row exitButton(BuildContext context) =>
Row (
  mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
  children: <Widget>[
    IconButton(
      icon: new Icon(Icons.close),  color: DefaultColors.disabledIconColor, onPressed: (){stepPageBack(context);}
          ),
        ],
);

Row logoutButton(BuildContext context) =>
Row (
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,  
  children: <Widget>[
    Text('Logout', style: TextStyle(color: DefaultColors.textColor)),
    IconButton(
      icon: new Icon(Icons.exit_to_app),  color: DefaultColors.disabledIconColor, onPressed: (){navigateToPageByRoute(Routes.LoginPage, context);}
          ),
        ],
);

Row deleteAccountButton(BuildContext context) =>
Row (
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,  
  children: <Widget>[
    FlatButton(
      padding: EdgeInsets.all(0),
      child: Text('Delete account',style: TextStyle(color: Colors.red)),
      onPressed: (){
        SystemNavigator.pop();
      },
    )
      
        ],
);
