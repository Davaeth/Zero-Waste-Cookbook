import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/src/pages/administation_panel/actions/models/administrator_action.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

class ActionsViewBuilder extends StatefulWidget {
  final List<AdministratorAction> _administratorActions;

  ActionsViewBuilder(this._administratorActions);

  @override
  _ActionsViewBuilderState createState() =>
      _ActionsViewBuilderState(_administratorActions);
}

class _ActionsViewBuilderState extends State<ActionsViewBuilder> {
  List<AdministratorAction> _administratorActions;
  List<int> indexes = List<int>();

  _ActionsViewBuilderState(this._administratorActions);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        body: SafeArea(
          child: GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: _administratorActions.length,
              itemBuilder: (BuildContext context, int index) => addPadding(
                  GestureDetector(
                    onLongPress: () {
                      _multipleSelect(index);
                    },
                    child: Card(
                      color: DefaultColors.backgroundColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildCircleAvatar(Icons.receipt),
                          Text(
                            'Test',
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  bottom: 8.0)),
          top: true,
        ),
      );

  CircleAvatar buildCircleAvatar(IconData iconData) {
    return CircleAvatar(
      child: Icon(
        iconData,
        size: 80.0,
      ),
      radius: 40.0,
    );
  }

  _multipleSelect(int index) {
    setState(() {
      if (indexes.contains(index)) {
        indexes.remove(index);
      } else {
        indexes.add(index);
      }
    });
  }
}
