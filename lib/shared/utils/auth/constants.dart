import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:open_art/shared/utils/styles.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Padding inputCheck(Color color) {
  return Padding(
      padding: const EdgeInsets.all(15.0),
      child: CircleAvatar(
        maxRadius: 10.r,
        backgroundColor: color,
        child: Icon(
          Icons.check,
          size: 13.sp,
          color: amTheme.white,
        ),
      ));
}

Padding buttonWidget(
    {@required VoidCallback buttonAction,
    @required Color buttonColor,
    @required String buttonText}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 16.h),
    child: Material(
      color: buttonColor,
      borderRadius: BorderRadius.all(Radius.circular(11.r)),
      elevation: 5,
      child: MaterialButton(
        onPressed: buttonAction,
        child: Styles.regular(
          buttonText,
        ),
      ),
    ),
  );
}

Center bottomText(
    {@required BuildContext context,
    @required String firstText,
    @required String secondText}) {
  return Center(
    child: RichText(
      text: TextSpan(
          text: firstText,
          style: TextStyle(
            fontSize: 10.sp,
            color: amTheme.white,
          ),
          children: [
            TextSpan(
                text: secondText,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: amTheme.green,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // navigate to desired screen
                  })
          ]),
    ),
  );
}

const String kRegexEmail =
    "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\$)";
const String kRegexNo = r'^(?:[+0][1-9])?[0-9]{10,12}$';
