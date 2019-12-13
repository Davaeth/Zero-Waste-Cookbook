import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

class LanguageDropdown extends StatefulWidget {
  @override
  _LanguageDropdownState createState() {
    return _LanguageDropdownState();
  }
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _value = 'pl';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          Translator.instance.translations['language'],
          style: TextStyle(color: DefaultColors.textColor),
        ),
        DropdownButtonHideUnderline(
          child: Theme(
            data: ThemeData(
              canvasColor: Colors.black,
            ),
            child: DropdownButton<String>(
              items: [
                _buildDropdownItem(
                    Translator.instance.translations['languages_list']
                        ['polish'],
                    'pl'),
                _buildDropdownItem(
                    Translator.instance.translations['languages_list']
                        ['english'],
                    'en'),
              ],
              onChanged: (String value) {
                setState(() async {
                  _value = value;

                  await Translator.instance.setLanguageType(_value);
                  await Translator.instance.getTranslations();
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
