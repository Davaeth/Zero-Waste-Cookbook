import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/page_resolver.dart';

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
                Image(
                    image: AssetImage("assets/images/logo_no_bg.png"),
                    height: 300.0),
                SizedBox(height: 50),
                _signInButton(),
              ],
            ),
          ),
        ),
      );

  Row _buildButtonContent() => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
              image: AssetImage("assets/images/google-logo.png"), height: 32.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Log in with Google',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          )
        ],
      );

  Widget _signInButton() => Container(
        width: (MediaQuery.of(context).size.width / 100) * 90,
        child: OutlineButton(
          splashColor: Colors.grey,
          onPressed: () => _signWithGoogle(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          highlightElevation: 0,
          borderSide: BorderSide(color: Colors.grey),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: _buildButtonContent(),
          ),
        ),
      );

  void _signWithGoogle() {
    signInWithGoogle.whenComplete(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => buildPage(context)),
      );
    });
  }
}
