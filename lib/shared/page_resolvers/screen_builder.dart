import 'package:flutter/material.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/constants/custom_bottom_app_bar.dart';

Scaffold buildPage(BuildContext context, Widget page) => Scaffold(
      backgroundColor: DefaultColors.backgroundColor,
      bottomNavigationBar: CustomBottomAppBar.createButtomAppBar(context),
      body: page,
    );
