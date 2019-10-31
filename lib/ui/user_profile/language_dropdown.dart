import 'package:flutter/material.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';



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
        DropdownButtonHideUnderline(child: 
        Theme(
          data: new ThemeData( canvasColor: Colors.black,
        ),
          child:
        DropdownButton<String>(
          items: [
            DropdownMenuItem<String>(
              child: Text('Polish', style: TextStyle(color: DefaultColors.textColor),),
              value: 'PL',
            ),
            DropdownMenuItem<String>(
              child: Text('English', style: TextStyle(color: DefaultColors.textColor)),
              value: 'ENG',
            ),
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
  }