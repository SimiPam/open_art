import 'package:flutter/material.dart';
import 'package:open_art/shared/utils/palette.dart';

class InputTextField extends StatelessWidget {
  InputTextField(
      {@required this.onDiff,
      @required this.checkIcon,
      @required this.hideText,
      this.inputDecoration,
      this.color,
      this.fieldController,
      this.fieldValidator});

  final Function(String) onDiff;
  final Widget checkIcon;
  final bool hideText;
  final Color color;
  final TextEditingController fieldController;
  final InputDecoration inputDecoration;
  final Function(String) fieldValidator;

  @override
  Widget build(BuildContext context) {
    bool check = false;
    return TextFormField(
      controller: fieldController,
      validator: fieldValidator,
      onChanged: onDiff,
      enableSuggestions: false,
      autocorrect: false,
      obscureText: hideText,
      style: TextStyle(
        fontSize: 18,
        color: color ?? Palette.darkBlue,
      ),
      decoration: inputDecoration,
    );
  }
}
