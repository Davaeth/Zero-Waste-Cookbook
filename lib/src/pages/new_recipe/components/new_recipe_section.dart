import 'package:flutter/material.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';

class NewRecipeSection extends StatefulWidget {
  final String _text;
  final Widget _child;

  NewRecipeSection(this._text, this._child);

  @override
  _NewRecipeSectionState createState() => _NewRecipeSectionState();
}

class _NewRecipeSectionState extends State<NewRecipeSection> {
  String _text;
  Widget _child;

  @override
  void initState() {
    _text = widget._text;
    _child = widget._child;

    super.initState();
  }

  @override
  Widget build(BuildContext context) => addPadding(
      Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: DefaultColors.iconColor),
                borderRadius: BorderRadius.circular(25.0)),
            child: Column(
              children: <Widget>[
                addPadding(
                    Text(
                      _text,
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    bottom: 8.0),
                _child
              ],
            ),
          )
        ],
      ),
      top: 16.0);
}
