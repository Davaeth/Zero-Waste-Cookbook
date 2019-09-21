import 'package:flutter/material.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';
import 'package:template_name/shared/ui/expansion_tiles/section.dart';

class ExpansionTileBuilder extends StatefulWidget {
  final Section _section;

  ExpansionTileBuilder(this._section);

  @override
  _ExpansionTileBuilderState createState() => _ExpansionTileBuilderState();
}

class _ExpansionTileBuilderState extends State<ExpansionTileBuilder> {
  Section _section;
  IconData _icon = Icons.keyboard_arrow_down;

  @override
  Widget build(BuildContext context) => Container(
        color: DefaultColors.secondaryColor,
        child: ExpansionTile(
          trailing: Icon(_icon, color: DefaultColors.iconColor),
          onExpansionChanged: (isCollapsed) {
            setState(() {
              _icon = isCollapsed
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down;
            });
          },
          backgroundColor: DefaultColors.secondaryColor,
          key: PageStorageKey<Section>(_section),
          title: createText(_section.title),
          children: createEntry(),
        ),
      );

  List<Padding> createEntry() {
    List<Padding> entries = [];

    for (var entry in widget._section.entries) {
      entries.add(
          addPadding(createText(entry), bottom: 8.0, left: 8.0, right: 8.0));
    }

    return entries;
  }

  @override
  void initState() {
    _section = widget._section;
    super.initState();
  }

  static Text createText(String text) => Text(
        text,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.justify,
      );
}
