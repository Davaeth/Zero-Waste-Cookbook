import 'package:flutter/material.dart';
import 'package:zero_waste_cookbook/ui/shared/colors/default_colors.dart';
import 'package:zero_waste_cookbook/ui/shared/page_resolvers/positioning.dart';

class UserRecipesManagerItem extends StatefulWidget {
  final String title;
  final double rate;

  UserRecipesManagerItem({@required this.title, @required this.rate});

  @override
  _UserRecipesManagerItemState createState() => _UserRecipesManagerItemState();
}

class _UserRecipesManagerItemState extends State<UserRecipesManagerItem>
    with TickerProviderStateMixin {
  AnimationController _iconAnimationController;

  String _title;
  double _rate;

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          alignment: Alignment.center,
          width: (MediaQuery.of(context).size.width / 100) * 90,
          height: (MediaQuery.of(context).size.height / 100) * 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: DefaultColors.secondaryColor,
          ),
          child: _buildUserRecipesTile(),
        ),
      );

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print(_title);

    super.initState();
  }

  Row _buildSubtitle() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.star,
            color: DefaultColors.iconColor,
          ),
          addPadding(
            Text(
              _rate.toString(),
              style: TextStyle(fontSize: 20.0, color: DefaultColors.textColor),
            ),
            left: 4.0,
          ),
        ],
      );

  ListTile _buildUserRecipesTile() {
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _rate = widget.rate;
    _title = widget.title;

    return ListTile(
      onTap: () {
        _iconAnimationController.reverse();
      },
      onLongPress: () {
        _iconAnimationController.forward();
      },
      leading: Icon(
        Icons.text_fields,
        size: 55.0,
        color: DefaultColors.iconColor,
      ),
      title: Text(
        _title,
        style: TextStyle(fontSize: 30.0, color: DefaultColors.textColor),
        textAlign: TextAlign.center,
      ),
      subtitle: _buildSubtitle(),
      trailing: AnimatedIcon(
        icon: AnimatedIcons.event_add,
        progress: _iconAnimationController,
        size: 35.0,
        color: DefaultColors.iconColor,
      ),
    );
  }
}

// Container(
//           width: (MediaQuery.of(context).size.width / 100) * 90,
//           height: (MediaQuery.of(context).size.height / 100) * 15,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0), color: Colors.red),
//         ),
