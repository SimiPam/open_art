import 'package:flutter/material.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final Function onPress;
  final Color txtColor;
  final double width;
  final double height;
  final double txtSize;
  final bool textIsBold;
  final bool lightmode;

  CustomOutlineButton(
      {Key key,
      @required this.title,
      @required this.onPress,
      this.txtColor,
      this.txtSize,
      this.width,
      this.height,
      this.textIsBold = false,
      this.lightmode = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      //margin: EdgeInsets.only(right: 24, bottom: 40),
      width: width ?? double.infinity,
      height: height ?? 60,
      child: OutlinedButton(
        onPressed: onPress,
        style: OutlinedButton.styleFrom(
          primary: lightmode ? amTheme.black : pmTheme.black,
          backgroundColor: Colors.transparent,
          side: BorderSide(
              color: txtColor ?? (lightmode ? amTheme.black : pmTheme.black),
              width: 1),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: txtColor ?? (lightmode ? amTheme.black : pmTheme.black),
            fontWeight: textIsBold ? FontWeight.w800 : FontWeight.w400,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
