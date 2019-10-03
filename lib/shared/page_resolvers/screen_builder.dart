import 'package:flutter/material.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/ui/constants/custom_bottom_navigation_bar.dart';

SafeArea buildPage(BuildContext context, Widget page) => SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        bottomNavigationBar: CustomNavigationBar(),
        body: page,
      ),
    );

GestureDetector switchToPage(
        BuildContext context, Widget child, Widget destinationPage) =>
    GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => destinationPage));
      },
      child: child,
    );
