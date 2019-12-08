import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/database/database_service.dart';
import 'package:zero_waste_cookbook/ui/constants/routes.dart';
import 'package:zero_waste_cookbook/ui/search/popular_categories_cards.dart';
import 'package:zero_waste_cookbook/ui/search/search_widget.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/navigator.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Widget _body;

  TextEditingController _nameSearchController;

  @override
  void initState() {
    _body = _buildNotSearchedBody(context);
    _nameSearchController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => ListView(
        children: [nameSearchWidget(_nameSearchController), _body],
      );

  Column _buildNotSearchedBody(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildFiltersSearchingButton(context),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Text(
              'Popular categories',
              style: TextStyle(fontSize: 24.0, color: DefaultColors.textColor),
            ),
          ),
          buildFullCardPopularRow(
            ['Fast food', 'Borgers'],
            [
              Image.asset('assets/images/borger.jpg'),
              Image.asset('assets/images/borger.jpg'),
            ],
          ),
        ],
      );

  MaterialButton _buildFiltersSearchingButton(BuildContext context) =>
      MaterialButton(
        child: Text('Filters'),
        textColor: DefaultColors.iconColor,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          navigateToPageByRoute(Routes.FiltersPage, context);
        },
      );
}
