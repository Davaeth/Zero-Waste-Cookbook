import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

class NewRecipeSection extends StatefulWidget {
  final String _text;
  final Widget _child;

  NewRecipeSection(this._text, this._child, {Key key}) : super(key: key);

  @override
  NewRecipeSectionState createState() => NewRecipeSectionState();
}

class NewRecipeSectionState extends State<NewRecipeSection> {
  String _text;
  Widget child;

  @override
  Widget build(BuildContext context) => addPadding(
      Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
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
                child
              ],
            ),
          )
        ],
      ),
      top: 16.0);

  @override
  void initState() {
    _text = widget._text;
    child = widget._child;

    super.initState();
  }
}
