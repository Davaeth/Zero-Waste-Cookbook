import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String _value = 'Meat';

  @override
  Widget build(BuildContext context) => DropdownButton<String>(
        value: _value,
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 20.0,
        style: TextStyle(color: Colors.white),
        items: <String>['Meat', 'Oil', 'Cheese']
            .map<DropdownMenuItem<String>>(
                (String value) => _createDropdownItem(value))
            .toList(),
      );

  DropdownMenuItem<String> _createDropdownItem(String value) =>
      DropdownMenuItem(
        value: value,
        child: Text(value),
      );
}
