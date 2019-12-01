import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:zero_waste_cookbook/src/pages/user_profile/user_profile.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

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
