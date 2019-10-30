import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template_name/src/pages/voting/components/hero_tags.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/navigator.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';

class FakeRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Hero(
        tag: fakeRecipe,
        child: Scaffold(
          backgroundColor: DefaultColors.backgroundColor,
          body: SafeArea(
            top: true,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: _setBoxDecoration(),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        color: DefaultColors.iconColor,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          stepPageBack(context);
                        },
                      ),
                    ),
                    _buildInfo('Author: ', 'test'),
                    addPadding(_buildInfo('Why you: ', 'Because I deserve it!'),
                        left: 8.0, right: 8.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  _buildInfo(String primaryText, String secondaryText) => addPadding(
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          addPadding(_buildInfoText(primaryText, 30.0, DefaultColors.iconColor),
              bottom: 8.0),
          _buildInfoText(secondaryText, 22.0, Colors.white)
        ],
      ),
      bottom: 16.0);

  _buildInfoText(String primaryText, double fontSize, Color color) =>
      addPadding(
          Text(
            primaryText,
            style: TextStyle(color: color, fontSize: fontSize),
          ),
          bottom: 8.0);

  _setBoxDecoration() => BoxDecoration(
      border: Border(
          bottom: BorderSide(color: DefaultColors.iconColor),
          top: BorderSide(color: DefaultColors.iconColor),
          left: BorderSide(color: DefaultColors.iconColor),
          right: BorderSide(color: DefaultColors.iconColor)),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(15.0),
      color: DefaultColors.secondaryColor);
}
