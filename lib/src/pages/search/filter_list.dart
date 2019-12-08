import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food/ingredient.dart';
import 'package:zero_waste_cookbook/src/models/food/recipe.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/region.dart';
import 'package:zero_waste_cookbook/src/pages/search/sreaching_result/searching_result.dart';
import 'package:zero_waste_cookbook/ui/constants/routes.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

class FiltersList extends StatefulWidget {
  final String collection;

  FiltersList({@required this.collection});

  @override
  _FiltersListState createState() => _FiltersListState();
}

class _FiltersListState extends State<FiltersList> {
  String _collection;

  List<String> _docReferences;

  DatabaseService _dbService;

  List<Color> _tileTextColors;
  List<Color> _tileColors;

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
          _buildSearchSubmitButton(context)
        ],
      );

  @override
  void initState() {
    _collection = widget.collection;

    _docReferences = List<String>();

    _dbService = DatabaseService();

    _tileColors = List<Color>();
    _tileTextColors = List<Color>();

    super.initState();
  }

  Padding _buildFilterButton(String text, String id, int index) => addPadding(
        Container(
          child: RaisedButton(
            color: _tileColors[index],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () => _updateFilters(id, index),
            child: Text(
              text,
              style: TextStyle(color: _tileTextColors[index]),
            ),
          ),
        ),
        left: 8.0,
        right: 8.0,
        bottom: 16.0,
      );

  StreamBuilder _buildFilterButtonsGrid() {
    return StreamBuilder<QuerySnapshot>(
      stream: _dbService.streamAllData(_collection),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
        if (snapshots.hasData) {
          var filters;

          if (_collection == 'Regions') {
            filters = _extractDishRegions(snapshots).toList();
          } else if (_collection == 'Ingredients') {
            filters = _extractIngredients(snapshots).toList();
          }

          return GridView.builder(
            shrinkWrap: true,
            controller: ScrollController(),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: filters.length,
            padding:
                EdgeInsets.only(left: 8.0, right: 4.0, top: 8.0, bottom: 4.0),
            itemBuilder: (context, index) => _buildFilterButton(
              filters[index].name,
              filters[index].id,
              index,
            ),
          );
        } else {
          return Column();
        }
      },
    );
  }

  Padding _buildSearchSubmitButton(BuildContext context) => addPadding(
      Container(
        width: (MediaQuery.of(context).size.width / 100) * 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(15.0)),
        child: FlatButton(
          onPressed: () {
            _showSearchingResult();
          },
          child: Text(
            'Search',
            style: TextStyle(color: DefaultColors.textColor, fontSize: 20.0),
          ),
        ),
      ),
      bottom: 8.0);

  Future<void> _showSearchingResult() async {
    print('testttttt');
    if (_collection == 'Regions') {
    } else if (_collection == 'Ingredients') {
      navigateToPageByRoute(
        Routes.SearchingResultPage,
        context,
        recipes: await _dbService.getRecipesByIngredients(_docReferences),
      );
    }
  }

  Iterable<Region> _extractDishRegions(
      AsyncSnapshot<QuerySnapshot> snapshots) sync* {
    for (var snapshot in snapshots?.data?.documents) {
      _tileColors.add(Colors.white);
      _tileTextColors.add(Colors.black);

      yield Region.fromFirestore(snapshot);
    }
  }

  Iterable<Ingredient> _extractIngredients(
      AsyncSnapshot<QuerySnapshot> snapshots) sync* {
    for (var snapshot in snapshots?.data?.documents) {
      _tileColors.add(Colors.white);
      _tileTextColors.add(Colors.black);

      yield Ingredient.fromFirestore(snapshot);
    }
  }

  void _updateFilters(String id, int index) {
    setState(() {
      if (!_docReferences.contains(id)) {
        _docReferences.add(id);

        _tileTextColors[index] = Colors.white;
        _tileColors[index] = DefaultColors.iconColor;
      } else {
        _docReferences.remove(id);

        _tileTextColors[index] = Colors.black;
        _tileColors[index] = Colors.white;
      }
    });
  }
}
