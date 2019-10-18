import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';

class FakeRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        body: addPadding(
            ListView(
              children: <Widget>[
                _buildInfoRow('Author: ', 'test'),
                _buildInfoRow('Description: ', 'TEststssfdsfs'),
                _buildInfoRow('Ingredients: ', 'sdsdsds ds ds d sd s dsd')
              ],
            ),
            left: 16.0,
            right: 16.0,
            top: 16.0),
      );

  Row _buildInfoRow(String primaryText, String secondaryText) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildInfoText(primaryText),
          _buildInfoText(secondaryText)
        ],
      );

  Padding _buildInfoText(String primaryText) => addPadding(
      Text(
        primaryText,
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
      bottom: 8.0);
}
