import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/pages/login/login_page.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/page_resolver.dart';

class AuthenticationCheck extends StatelessWidget {
  final bool _isLogged;

  AuthenticationCheck(this._isLogged);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      
      if (_isLogged) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => buildPage(context)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });
  }
}
