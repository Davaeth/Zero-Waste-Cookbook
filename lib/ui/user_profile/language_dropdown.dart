import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';

class LanguageDropdown extends StatefulWidget {
  @override
  _LanguageDropdownState createState() {
    return _LanguageDropdownState();
  }
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _value = 'PL';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Language', style: TextStyle(color: DefaultColors.textColor)),
        DropdownButtonHideUnderline(
          child: Theme(
            data: ThemeData(
              canvasColor: Colors.black,
            ),
            child: DropdownButton<String>(
              items: [
                _buildDropdownItem('Polish', 'PL'),
                _buildDropdownItem('English', 'EN'),
              ],
              onChanged: (String value) {
                setState(() {
                  _value = value;
                });
              },
              value: _value,
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> _buildDropdownItem(
          String language, String languageShortcut) =>
      DropdownMenuItem<String>(
        child: Text(
          language,
          style: TextStyle(color: DefaultColors.textColor),
        ),
        value: languageShortcut,
      );
}
