import 'package:flutter/material.dart';
import 'package:template_name/ui/constants/routes.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/navigator.dart';
import 'package:template_name/ui/shared/page_resolvers/positioning.dart';

class Voting extends StatefulWidget {
  @override
  _VotingState createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  List<GestureDetector> _votings;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: DefaultColors.backgroundColor,
        body: addPadding(
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: _votings.length > 0
                      ? _votings
                      : [
                          _buildVotingObjectInterior(
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Brak kandydatur',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                              DefaultColors.backgroundColor)
                        ],
                ),
                addPadding(
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _buildDragTarget(Colors.green, Icons.add),
                        _buildDragTarget(Colors.red, Icons.close)
                      ],
                    ),
                    top: 128.0)
              ],
            ),
            top: MediaQuery.of(context).size.height * 0.15),
      );

  @override
  void initState() {
    _votings = _buiildVotingObjects(3).toList();

    super.initState();
  }

  Iterable<GestureDetector> _buiildVotingObjects(int votingsCount) sync* {
    for (var i = 0; i < votingsCount; i++) {
      yield _buildVotingObject(context);
    }
  }

  DragTarget<int> _buildDragTarget(Color color, IconData iconData) {
    return DragTarget(
      builder: (context, List<int> candidateData, rejectedData) => Container(
        width: 120.0,
        height: 120.0,
        child: Card(
          color: color,
          child: Icon(
            iconData,
            size: 80.0,
          ),
        ),
      ),
    );
  }

  Align _buildInfoText() => Align(
        alignment: Alignment.center,
        child: Text(
          'Test przepis',
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
      );

  GestureDetector _buildVotingObject(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToPageByRoute(Routes.FakeRecipePage, context);
      },
      child: Draggable(
        child: _buildVotingObjectInterior(
            _buildInfoText(), DefaultColors.secondaryColor),
        feedback: Material(
          color: Colors.transparent,
          child: _buildVotingObjectInterior(
              _buildInfoText(), DefaultColors.secondaryColor),
        ),
        childWhenDragging:
            _buildVotingObjectInterior(null, DefaultColors.backgroundColor),
        onDragEnd: (details) {
          setState(() {
            _votings.removeLast();
          });
        },
      ),
    );
  }

  Container _buildVotingObjectInterior(Widget child, Color color) {
    return Container(
      width: 160.0,
      height: 160.0,
      child: Card(
        color: color,
        child: child,
      ),
    );
  }
}
