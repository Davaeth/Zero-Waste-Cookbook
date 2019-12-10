import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

class RecipesViewBuilder extends StatefulWidget {
  @override
  _RecipesViewBuilderState createState() => _RecipesViewBuilderState();
}

class _RecipesViewBuilderState extends State<RecipesViewBuilder> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        body: SafeArea(
          child: ListView(),
          top: true,
          bottom: true,
        ),
      );
}
