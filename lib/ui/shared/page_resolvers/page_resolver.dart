import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/main.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/administrator_panel.dart';
import 'package:zero_waste_cookbook/src/pages/search/search_page.dart';
import 'package:zero_waste_cookbook/src/pages/user_profile/user_profile.dart';
import 'package:zero_waste_cookbook/ui/constants/custom_bottom_navigation_bar.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

SafeArea buildPage(BuildContext context) => SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: DefaultColors.backgroundColor,
          bottomNavigationBar: CustomNavigationBar(),
          body: TabBarView(
            children: [
              MyHomePage(),
              AdministratorPanel(),
              Search(),
              UserProfile()
            ],
          ),
        ),
      ),
    );
