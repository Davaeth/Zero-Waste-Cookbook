import 'package:flutter/material.dart';
import 'dart:async';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/pages/user_profile.dart';
import 'package:flare_flutter/flare_actor.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => UserProfile())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColors.backgroundColor,
      body: Center(
        child: FlareActor(
          'assets/splashintro.flr',
          animation: 'Untitled',
          snapToEnd: false,
        ),
      ),
    );
  }
}