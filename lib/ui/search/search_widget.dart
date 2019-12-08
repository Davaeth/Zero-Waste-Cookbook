import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

Padding nameSearchWidget(TextEditingController nameSearchController) =>
    addPadding(
      Container(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: nameSearchController,
          cursorColor: DefaultColors.iconColor,
          style: TextStyle(color: DefaultColors.textColor, height: 0.8),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: DefaultColors.disabledIconColor),
            hintText: 'Search by name',
            prefixIcon: Icon(Icons.search, color: DefaultColors.iconColor),
            enabledBorder:
                _buildOutlineInputBorder(DefaultColors.disabledIconColor),
            focusedBorder: _buildOutlineInputBorder(DefaultColors.iconColor),
          ),
        ),
      ),
    );

OutlineInputBorder _buildOutlineInputBorder(Color borderColor) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
    borderSide: BorderSide(color: borderColor),
  );
}
