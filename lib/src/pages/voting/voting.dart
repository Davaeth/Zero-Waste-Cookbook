import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:template_name/src/pages/voting/components/hero_tags.dart';
import 'package:template_name/ui/constants/routes.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';
import 'package:template_name/ui/shared/page_resolvers/navigator.dart';

class Voting extends StatefulWidget {
  @override
  _VotingState createState() => _VotingState();
}

class _VotingState extends State<Voting> {
  CardController _cardController;
  List<Color> _cardColors;
  int _activeIndex;

  @override
  Widget build(BuildContext context) => Container(
        color: DefaultColors.backgroundColor,
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.6,
        child: GestureDetector(
            onTap: () {
              navigateToPageByRoute(Routes.FakeRecipePage, context);
            },
            child: TinderSwapCard(
                animDuration: 10,
                orientation: AmassOrientation.BOTTOM,
                totalNum: 6,
                stackNum: 4,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.width * 0.6,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                minHeight: MediaQuery.of(context).size.width * 0.5,
                cardBuilder: (context, int index) {
                  fakeRecipe = 'fakeRecipe$index';
                  _activeIndex = index;
                  return _buildVotingHeroCard(index);
                },
                cardController: _cardController,
                swipeCompleteCallback: _handleSwapComplete,
                swipeUpdateCallback: _handleSwapUpdate)),
      );

  @override
  void initState() {
    _cardController = CardController();
    _cardColors = List<Color>();

    for (var i = 0; i < 6; i++) {
      _cardColors.add(DefaultColors.secondaryColor);
    }

    super.initState();
  }

  Hero _buildVotingHeroCard(int index) => Hero(
        tag: fakeRecipe,
        child: Card(
          borderOnForeground: true,
          color: _cardColors[index],
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Test recipe title',
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ),
        ),
      );

  void _handleSwapComplete(CardSwipeOrientation orientation, int index) {
    if (orientation == CardSwipeOrientation.LEFT) {
      setState(() {
        _cardColors.forEach((color) {
          color = Colors.green;
        });
        print(_cardColors[0]);
      });
    } else if (orientation == CardSwipeOrientation.RIGHT) {
      print('Odrzucam');
    }
  }

  _handleSwapUpdate(DragUpdateDetails details, Alignment align) {
    setState(() {
      if (align.x < 0) {
        _cardColors[_activeIndex] = Colors.green;
      } else if (align.x > 0) {
        _cardColors[_activeIndex] = Colors.red;
      } else {
        _cardColors[_activeIndex] = DefaultColors.secondaryColor;
      }
    });
  }
}
