import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/dish_region.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

class DishRegionsDropdown extends StatefulWidget {
  final Function(DishRegion) callback;

  DishRegionsDropdown({this.callback});

  @override
  _DishRegionsDropdownState createState() => _DishRegionsDropdownState();
}

class _DishRegionsDropdownState extends State<DishRegionsDropdown> {
  String _value = 'Poland';

  List<DishRegion> _dishRegions;

  DatabaseService _databaseService;

  Function(DishRegion) _callback;

  @override
  Widget build(BuildContext context) => DropdownButtonHideUnderline(
        child: Theme(
          data: ThemeData(canvasColor: DefaultColors.backgroundColor),
          child: FutureBuilder(
            future: _databaseService.getAllData('Regions'),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                _createDropdownData(context, snapshot);

                return DropdownButton<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 20.0,
                  style: TextStyle(color: Colors.white),
                  items: _createDropdownItems(_dishRegions).toList(),
                  onChanged: (String value) {
                    setState(() {
                      _value = value;
                      _callback(_getChosenDishRegion(value));
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
    _dishRegions = List<DishRegion>();
    _callback = widget.callback;

    super.initState();
  }

  _createDropdownData(context, AsyncSnapshot<QuerySnapshot> snapshot) {
    _dishRegions = List<DishRegion>();

    snapshot.data.documents.forEach((dishRegion) {
      _dishRegions.add(DishRegion.fromFirestore(dishRegion));
    });

    _callback(_dishRegions.first);
  }

  Iterable<DropdownMenuItem<String>> _createDropdownItems(
      List<DishRegion> _dishRegions) sync* {
    for (var dishRegion in _dishRegions) {
      yield DropdownMenuItem<String>(
        value: dishRegion.regionName,
        child: Text(
          dishRegion.regionName,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  DishRegion _getChosenDishRegion(String name) {
    for (var dishRegion in _dishRegions) {
      if (dishRegion.regionName == name) {
        return dishRegion;
      }
    }
  }
}
