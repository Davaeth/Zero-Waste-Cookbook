import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/main.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/administrator_panel.dart';
import 'package:zero_waste_cookbook/src/pages/search/search_page.dart';
import 'package:zero_waste_cookbook/src/pages/user_profile/user_profile.dart';
import 'package:zero_waste_cookbook/ui/constants/custom_bottom_navigation_bar.dart';
import 'package:zero_waste_cookbook/ui/login/google_login.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

SafeArea buildPage(BuildContext context) => SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: DefaultTabController(
        length: (checkIfCurrentUserIsAdmin()) ? 4 : 3,
        child: Scaffold(
          backgroundColor: DefaultColors.backgroundColor,
          bottomNavigationBar: (checkIfCurrentUserIsAdmin()) ? CustomNavigationBarAdmin() : CustomNavigationBar(),
          body: TabBarView(
            children: sw(),
//             [
//              MyHomePage(),
//              Search(),
//              UserProfile(),
//              AdministratorPanel()
//            ],
          ),
        ),
      ),
    );

List<Widget> sw() 
{
  List<Widget> lsw = [ MyHomePage(), Search(), UserProfile() ];
  if(checkIfCurrentUserIsAdmin()){
    lsw.add(AdministratorPanel());
  }
  return lsw;
} 

bool checkIfCurrentUserIsAdmin(){ return (currentUserId == 'h9XKAzNrlcYUHRjBtmFqjvEy6J72') ? true : false;}