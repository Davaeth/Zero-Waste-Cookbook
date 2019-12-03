import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/src/models/food_addons/difficulty_level.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

class DifficultyLevelDropdown extends StatefulWidget {
  final Function(DifficultyLevel) callback;

  DifficultyLevelDropdown({this.callback});

  @override
  _DifficultyLevelDropdownState createState() =>
      _DifficultyLevelDropdownState();
}

class _DifficultyLevelDropdownState extends State<DifficultyLevelDropdown> {
  String _value = 'test';

  List<DifficultyLevel> _difficultyLevels;

  DatabaseService _databaseService;

  Function(DifficultyLevel) _callback;

  @override
  Widget build(BuildContext context) => DropdownButtonHideUnderline(
        child: Theme(
          data: ThemeData(canvasColor: DefaultColors.backgroundColor),
          child: StreamBuilder(
            stream: _databaseService.getAllData('DifficultyLevels'),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              _createDropdownData(snapshot);

              return DropdownButton<String>(
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: 20.0,
                style: TextStyle(color: Colors.white),
                items: _createDropdownItems(_difficultyLevels).toList(),
                onChanged: (String value) {
                  setState(() {
                    _value = value;
                    _callback(_getChosenDifficultyLevel(value));
                  });
                },
                value: _value,
              );
            },
          ),
        ),
      );

  @override
  void initState() {
    _databaseService = DatabaseService();
    _difficultyLevels = List<DifficultyLevel>();
    _callback = widget.callback;

    super.initState();
  }

  _createDropdownData(AsyncSnapshot<QuerySnapshot> snapshot) {
    _difficultyLevels = List<DifficultyLevel>();

    snapshot.data.documents.forEach((difficultyLevel) {
      _difficultyLevels.add(DifficultyLevel.fromFirestore(difficultyLevel));
    });

    _callback(_difficultyLevels.first);
  }

  Iterable<DropdownMenuItem<String>> _createDropdownItems(
      List<DifficultyLevel> _difficultyLevels) sync* {
    for (var difficultyLevel in _difficultyLevels) {
      yield DropdownMenuItem<String>(
        value: difficultyLevel.difficultyLevelName,
        child: Text(
          difficultyLevel.difficultyLevelName,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  DifficultyLevel _getChosenDifficultyLevel(String name) {
    for (var difficultyLevel in _difficultyLevels) {
      if (difficultyLevel.difficultyLevelName == name) {
        return difficultyLevel;
      }
    }
  }
}
