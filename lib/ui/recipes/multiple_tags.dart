import 'package:flutter/material.dart';

class MultipleTags extends StatelessWidget {
  final List<Widget> _namedTags;
  final Widget cookingTimeTag;

  final List<Widget> _widgets = List<Widget>();

  MultipleTags(this._namedTags, {this.cookingTimeTag}) {
    _widgets.add(cookingTimeTag);
    _widgets.add(_namedTags.first);
    _widgets.add(_namedTags.length > 1 ? _namedTags[1] : null);
  }

  @override
  Widget build(BuildContext context) => _createRowOfTags(_widgets);

  Row _createRowOfTags(List<Widget> widgets) =>
      Row(children: widgets.where((widget) => widget != null).toList());

  static Card createTag(String text, {IconData icon}) => Card(
        color: Colors.transparent,
        shape: StadiumBorder(
            side: BorderSide(
          color: Colors.grey,
          width: 2.0,
        )),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: icon == null
              ? _createTag(text)
              : _createCookingTimeTag(text, icon),
        ),
      );

  static Row _createCookingTimeTag(String text, IconData icon) => Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Icon(icon, size: 20.0, color: Colors.white),
          ),
          _createTag(text),
        ],
      );

  static Text _createTag(String text) => Text(
        text,
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      );
}