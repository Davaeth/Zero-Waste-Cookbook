import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/pages/search/search_filters.dart';
import 'package:zero_waste_cookbook/ui/search/name_search.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with NameSearch {
  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        children: [
          nameSearchWidget(context),
          Filters(),
        ],
      );
}
