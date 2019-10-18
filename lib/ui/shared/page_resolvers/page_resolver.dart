import 'package:flutter/material.dart';
import 'package:template_name/main.dart';
import 'package:template_name/src/pages/administation_panel/administrator_panel.dart';
import 'package:template_name/ui/constants/custom_bottom_navigation_bar.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';

SafeArea buildPage(BuildContext context) => SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: DefaultColors.backgroundColor,
          bottomNavigationBar: CustomNavigationBar(),
          body: TabBarView(children: [MyHomePage(), AdministratorPanel()]),
        ),
      ),
    );
