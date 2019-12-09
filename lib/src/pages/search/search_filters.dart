import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/pages/search/filter_list.dart';

class Filters extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: ListView(
          controller: ScrollController(),
          shrinkWrap: true,
          children: <Widget>[
            FiltersList(collection: 'Regions'),
            FiltersList(collection: 'Ingredients'),
          ],
        ),
      );
}
