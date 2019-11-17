import 'package:flutter/material.dart';
import 'package:template_name/ui/shared/colors/default_colors.dart';

class InputField extends StatelessWidget {
  InputField(
      {this.icon,
      this.hint,
      this.obscure = false,
      this.validator,
      this.onSaved});
  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final bool obscure;
  final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:8.0, bottom: 8.0, left:40.0, right:40.0),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        autofocus: true,
        obscureText: obscure,
        style: TextStyle(color: DefaultColors.textColor, height: 0.8),
        textAlign: TextAlign.center,
        cursorColor: DefaultColors.iconColor,
        decoration: InputDecoration(
            hintStyle: TextStyle(color: DefaultColors.disabledIconColor),
            hintText: hint,
             enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: DefaultColors.disabledIconColor),),
             focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: DefaultColors.iconColor),)
                        ),
            ),
    );
  }
}