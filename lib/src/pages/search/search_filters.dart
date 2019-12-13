import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/pages/search/filter_list.dart';
import 'package:zero_waste_cookbook/utils/singletons/translator.dart';

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
            FiltersList(
              collection: 'Regions',
              sectionTitle: Translator.instance.translations['region'],
            ),
            FiltersList(
              collection: 'Ingredients',
              sectionTitle: Translator.instance.translations['ingredients'],
            ),
          ],
        ),
      );
}
