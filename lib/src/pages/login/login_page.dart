import 'package:flutter/material.dart';
import 'package:template_name/src/pages/search/search_page.dart';
import 'package:template_name/src/pages/user_profile/user_profile.dart';
import 'package:template_name/ui/constants/routes.dart';
import 'package:template_name/ui/login/google_login.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/navigator.dart';
import 'package:template_name/ui/shared/page_resolvers/page_resolver.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
 Widget build(BuildContext context) => Scaffold(
      body: Container(
        color: DefaultColors.backgroundColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/images/logo_no_bg.png"), height: 300.0),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );


Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
    signInWithGoogle().whenComplete(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => buildPage(context)));
          });
        },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/google-logo.png"), height: 32.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Zaloguj za pomocą konta Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}