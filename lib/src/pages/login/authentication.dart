import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/pages/login/login_page.dart';

class AuthenticationCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }
}
