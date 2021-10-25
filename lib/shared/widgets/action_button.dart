import 'package:flutter/material.dart';
import 'package:open_art/core/services/utilities_service.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:open_art/shared/widgets/space.dart';


class ActionButton extends StatelessWidget {
  const ActionButton({
    this.clicked,
    this.text,
    this.suffix,
    this.loading = false,
    this.disabled = false,
    this.color,
    this.height,
    this.width,
    this.padding,
    this.radius,
    this.fontSize,
    this.textColor,
    this.loadingText = '',
    this.borderColor,
    this.prefix,
    this.customTextWidget,
    this.fontWeight,
  });

  final void Function() clicked;
  final Widget suffix;
  final Widget prefix;
  final String text;
  final bool loading;
  final bool disabled;
  final Color color;
  final double height;
  final double padding;
  final double width;
  final BorderRadiusGeometry radius;
  final double fontSize;
  final Color textColor;
  final String loadingText;
  final Color borderColor;
  final Widget customTextWidget;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = color ?? pmTheme.black;
    final Color derivedTextColor = textColor ?? pmTheme.white;
    final double pd = padding ?? 15;

    return Container(
      height: height,
      width: width ?? double.infinity,
      child: ButtonTheme(
        splashColor: bgColor.withOpacity(0.5),
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              derivedTextColor.withOpacity(loading || disabled ? 0.5 : 1),
            ),
            overlayColor: MaterialStateColor.resolveWith(
              (Set<MaterialState> states) => bgColor.withOpacity(0.5),
            ),
            backgroundColor: MaterialStateProperty.all(
              bgColor.withOpacity(loading || disabled ? 0.4 : 1),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.all(pd)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: radius ?? BorderRadius.circular(Dims.dx(5)),
                side: BorderSide(
                  color: loading || disabled
                      ? borderColor ?? bgColor.withOpacity(0.1)
                      : borderColor ?? bgColor,
                ),
              ),
            ),
          ),
          onPressed: loading || disabled
              ? null
              : () {
                  UtilitiesService.removeFocus(context);

                  if (clicked != null) {
                    clicked();
                  }
                },
          child: loading && loadingText.isEmpty
              ? UtilitiesService.progress(size: Dims.dx(20))
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (prefix != null) prefix,
                    if (prefix != null) HSpace(Dims.dx(10)),
                    customTextWidget ??
                        Styles.medium(
                          (loading ? loadingText : text) ?? '',
                          fontSize: fontSize ?? Dims.dx(15),
                          color: derivedTextColor,
                        ),
                    if (suffix != null) HSpace(Dims.dx(10)),
                    if (suffix != null) suffix,
                  ],
                ),
        ),
      ),
    );
  }
}
