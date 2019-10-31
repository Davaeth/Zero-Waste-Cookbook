import 'package:flutter/material.dart';
import 'package:template_name/src/pages/new_recipe/components/new_recipe_section.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/navigator.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';

class NewRecipe extends StatefulWidget {
  @override
  _NewRecipeState createState() => _NewRecipeState();
}

class _NewRecipeState extends State<NewRecipe> {
  TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        body: SafeArea(
          top: true,
          child: ListView(
            children: <Widget>[
              IconButton(
                alignment: Alignment.topRight,
                icon: Icon(Icons.close),
                color: DefaultColors.iconColor,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                iconSize: 30.0,
                onPressed: () {
                  stepPageBack(context);
                },
              ),
              NewRecipeSection(
                  'Title', _buildTextField(TextInputType.text, context)),
              NewRecipeSection(
                  'Description',
                  _buildTextField(TextInputType.multiline, context,
                      maxLines: null, length: null)),
              NewRecipeSection(
                  'Ingredients',
                  ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      _buildIngredient(),
                      _buildIngredient(),
                    ],
                  ))
            ],
          ),
        ),
      );

  Row _buildIngredient() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          addPadding(
              Text(
                'Test',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              left: 8.0),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              /*TOFO('Remove from the ingredients list');*/
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: Colors.white,
          ),
        ],
      );

  Container _buildTextField(TextInputType inputType, BuildContext context,
          {int maxLines = 1, int length = 20}) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: DefaultColors.secondaryColor,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextFormField(
          keyboardType: inputType,
          maxLines: maxLines,
          maxLength: length,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          textAlign: TextAlign.center,
          controller: _descriptionController,
          decoration:
              InputDecoration(border: InputBorder.none, counterText: ''),
        ),
      );
}
