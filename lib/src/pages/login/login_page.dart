import 'package:flutter/material.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';

class Login extends StatelessWidget {
   @override
  Widget build(BuildContext context) => SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          backgroundColor: DefaultColors.backgroundColor,
          body: ListView(
            shrinkWrap: true,
            children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
          Text('Submit')
        ])
      ]
      ),
        ),
  );
}
