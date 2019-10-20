import 'package:flutter/material.dart';
import 'package:template_name/main.dart';
import 'package:template_name/pages/administation_panel/administrator_panel.dart';
import 'package:template_name/pages/search_page.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/ui/constants/custom_bottom_navigation_bar.dart';
import 'package:template_name/pages/user_profile.dart';


SafeArea buildPage(BuildContext context, int pageIndex) => SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: DefaultColors.backgroundColor,
          bottomNavigationBar: CustomNavigationBar(),
          body: TabBarView(children: [MyHomePage(), AdministratorPanel(), SearchPage(), UserProfile()]),
        ),
      ),
    );
