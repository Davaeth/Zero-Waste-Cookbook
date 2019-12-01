import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:template_name/src/pages/login/login_page.dart';
import 'package:template_name/ui/constants/routes.dart';
import 'package:template_name/ui/shared/page_resolvers/navigator.dart';
import 'package:template_name/ui/shared/page_resolvers/page_resolver.dart';


class AuthenticationCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context)
  {

  Future.delayed(Duration.zero, () {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  });
}
  

}