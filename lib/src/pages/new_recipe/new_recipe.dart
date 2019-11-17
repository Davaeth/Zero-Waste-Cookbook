import 'package:flutter/material.dart';
import 'package:template_name/src/models/user.dart';
import 'package:template_name/src/pages/new_recipe/components/new_recipe_section.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/navigator.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';
import 'package:template_name/src/database/database_service.dart';

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
            shrinkWrap: true,
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
                  'Ingredients',
                  ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      _buildIngredient(),
                      _buildIngredient(),
                    ],
                  )),
              addPadding(
                  Container(
                    width: 1.0,
                    child: FlatButton(
                      child: Text('Add an ingredient'),
                      onPressed: () {
                        final _user = User(username: 'Belka');
 
                        final _dbService = DatabaseService();
 
                        _dbService.createUser(_user.toJson());
                      },
                      color: DefaultColors.iconColor,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                  ),
                  top: 16.0),
              NewRecipeSection(
                  'Directions',
                  _buildTextField(TextInputType.multiline, context,
                      maxLines: null, length: null)),
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
              /*TODO('Remove from the ingredients list');*/
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