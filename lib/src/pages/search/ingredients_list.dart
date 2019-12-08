import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/ingredient.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

class IngredientsList extends StatefulWidget {
  @override
  _IngredientsListState createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  String _collection;

  @override
  void initState() {
    _collection = 'Ingredients';

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _collection,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
                  color: DefaultColors.iconColor),
            ),
          ),
          _buildFilterButtonsGrid(),
        ],
      );

  StreamBuilder _buildFilterButtonsGrid() {
    DatabaseService _dbService = DatabaseService();

    return StreamBuilder<QuerySnapshot>(
      stream: _dbService.streamAllData(_collection),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
        if (snapshots.hasData) {
          var ingredients = _extractIngredients(snapshots).toList();

          return GridView.builder(
            shrinkWrap: true,
            controller: ScrollController(),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: ingredients.length,
            padding:
                EdgeInsets.only(left: 8.0, right: 4.0, top: 8.0, bottom: 4.0),
            itemBuilder: (context, index) =>
                _buildFilterButton(ingredients[index]),
          );
        } else {
          return Column();
        }
      },
    );
  }

  Iterable<Ingredient> _extractIngredients(
      AsyncSnapshot<QuerySnapshot> snapshots) sync* {
    for (var snapshot in snapshots?.data?.documents) {
      yield Ingredient.fromFirestore(snapshot);
    }
  }

  Padding _buildFilterButton(Ingredient ingredient) => addPadding(
        Container(
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {},
            child: Text(ingredient.name),
          ),
        ),
        left: 8.0,
        right: 8.0,
        bottom: 16.0,
      );
}
