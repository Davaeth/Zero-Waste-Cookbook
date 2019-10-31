import 'package:flutter/material.dart';
import 'package:template_name/main.dart';
import 'package:template_name/pages/administation_panel/administrator_panel.dart';
import 'package:template_name/pages/one_recipe/single_recipe.dart';
import 'package:template_name/shared/enums/page.dart';
import 'package:template_name/pages/search/search_filters.dart';
import 'package:template_name/pages/user_profile_settings.dart';
import 'package:template_name/pages/login/login_page.dart';

List<Widget> _pages = [MyHomePage(), SingleRecipe(), AdministratorPanel(), Filters(), Settings(), Login()  ];

void navigateToPageByScreen(Page page, BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => _pages[page.index]));
}

void navigateToPageByNumber(int page, BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => _pages[page]));
}

void stepPageBack(BuildContext context) {
  Navigator.pop(context);
}

GestureDetector switchPage(BuildContext context, Widget child, Page page) =>
    GestureDetector(
      onTap: () {
        navigateToPageByScreen(page, context);
      },
      child: child,
    );
