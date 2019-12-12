import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

class CustomNavigationBar extends StatefulWidget {
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) => buildBottomAppBar();

  BottomAppBar buildBottomAppBar() => BottomAppBar(
        color: DefaultColors.secondaryColor,
        child: TabBar(
          indicatorColor: Colors.transparent,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.white70,
          tabs: <Widget>[
            _buildAppBarIcon(Icons.home),
            _buildAppBarIcon(Icons.star),
            _buildAppBarIcon(Icons.account_balance),
//            _buildAppBarIcon(Icons.supervised_user_circle),
          ],
        ),
      );

  Icon _buildAppBarIcon(IconData iconData) => Icon(
        iconData,
        size: 38.0,
      );
}

class CustomNavigationBarAdmin extends StatefulWidget {
  @override
  _CustomNavigationBarStateAdmin createState() => _CustomNavigationBarStateAdmin();
}

class _CustomNavigationBarStateAdmin extends State<CustomNavigationBarAdmin> {
  @override
  Widget build(BuildContext context) => buildBottomAppBar();

  BottomAppBar buildBottomAppBar() => BottomAppBar(
        color: DefaultColors.secondaryColor,
        child: TabBar(
          indicatorColor: Colors.transparent,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.white70,
          tabs: <Widget>[
            _buildAppBarIcon(Icons.home),
            _buildAppBarIcon(Icons.star),
            _buildAppBarIcon(Icons.account_balance),
            _buildAppBarIcon(Icons.supervised_user_circle),
          ],
        ),
      );

  Icon _buildAppBarIcon(IconData iconData) => Icon(
        iconData,
        size: 38.0,
      );
}
