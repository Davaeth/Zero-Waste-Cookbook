import 'package:flutter/material.dart';
import 'package:template_name/shared/behaviours/custom_scroll_behavior.dart';
import 'package:template_name/shared/enums/page.dart';
import 'package:template_name/shared/page_resolvers/navigator.dart';
import 'package:template_name/shared/page_resolvers/positioning.dart';
import 'package:template_name/shared/page_resolvers/page_resolver.dart';
import 'package:template_name/shared/ui/cards/recipe_card.dart';
import 'package:template_name/shared/ui/recipes/recipes_manager.dart';
import 'package:template_name/shared/colors/default_colors.dart';
import 'package:template_name/shared/ui/constants/custom_bottom_navigation_bar.dart';
import 'package:template_name/shared/ui/recipes/recipes_manager.dart';
import 'package:template_name/shared/ui/recipes/fav_recipes.dart';
import 'package:template_name/shared/ui/user_profile/user_info.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) => wrapWithScrollingView(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            switchPage(
                context,
                buildUserInfo(['100k','2'], [Icons.star, Icons.comment], 'BoyMan'),
                Page.RecipePage),
            addPadding(
                Text(
                  'Favourite recipes',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                left: 16.0,
                top: 8.0,
                bottom: 8.0),
            Expanded(
              child: FavRecipesManager(),
            )
          ]));
}  

// class UpperSection extends StatelessWidget {
//   const UpperSection({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
      
//         Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Container(
//                     padding: const EdgeInsets.all(24.0),
//                     child:
//                   MaterialButton(
//                     child: Text('Add new recipe'),
//                     color: DefaultColors.iconColor,
//                     textColor: DefaultColors.textColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(18.0),
//                       side: BorderSide(color:DefaultColors.iconColor),
//                     ),
//                     onPressed: (){},
//                   ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: <Widget>[
//                   Container(
//                     padding: const EdgeInsets.all(24.0),
//                     child:
//                   MaterialButton(
//                     child: Text('Manage my recipes'),
//                     color: DefaultColors.iconColor,
//                     textColor: DefaultColors.textColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(18.0),
//                       side: BorderSide(color:DefaultColors.iconColor),
//                     ),
//                     onPressed: (){},
//                   ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//     );
//   }
// }