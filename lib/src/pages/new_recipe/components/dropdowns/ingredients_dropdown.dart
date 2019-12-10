import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/ingredient.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

class IngredientsDropdown extends StatefulWidget {
  final Function(Ingredient) callback;

  IngredientsDropdown({this.callback});

  @override
  _IngredientsDropdownState createState() => _IngredientsDropdownState();
}

class _IngredientsDropdownState extends State<IngredientsDropdown> {
  String _value = 'Cheese';

  List<Ingredient> _ingredients;

  DatabaseService _databaseService;

  Function(Ingredient) _callback;

  @override
  Widget build(BuildContext context) => DropdownButtonHideUnderline(
        child: Theme(
          data: ThemeData(canvasColor: DefaultColors.backgroundColor),
          child: FutureBuilder(
            future: _databaseService.getAllData('Ingredients'),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                _createDropdownData(context, snapshot);

                return DropdownButton<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 20.0,
                  style: TextStyle(color: Colors.white),
                  items: _createDropdownItems(_ingredients).toList(),
                  onChanged: (String value) {
                    setState(() {
                      _value = value;
                      _callback(_getChosenIngredient(value));
                    });
                  },
                  value: _value,
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      );

  @override
  void initState() {
    _databaseService = DatabaseService();
    _ingredients = List<Ingredient>();
    _callback = widget.callback;

    super.initState();
  }

  _createDropdownData(context, AsyncSnapshot<QuerySnapshot> snapshot) {
    _ingredients = List<Ingredient>();

    snapshot.data.documents.forEach((ingredient) {
      _ingredients.add(Ingredient.fromFirestore(ingredient));
    });
  }

  Iterable<DropdownMenuItem<String>> _createDropdownItems(
      List<Ingredient> ingredients) sync* {
    for (var ingredient in ingredients) {
      yield DropdownMenuItem<String>(
        value: ingredient.name,
        child: Text(
          ingredient.name,
          style: TextStyle(color: Colors.white, fontSize: 18.0),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Ingredient _getChosenIngredient(String name) {
    for (var ingredient in _ingredients) {
      if (ingredient.name == name) {
        return ingredient;
      }
    }
  }
}
