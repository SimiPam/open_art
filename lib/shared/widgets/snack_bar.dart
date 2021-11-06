import 'package:flutter/material.dart';
import 'package:open_art/core/viewmodel/appTheme.dart';
import 'package:open_art/modules/scan/scan_page.dart';
import 'package:open_art/shared/utils/themes/theme.dart';
import 'package:open_art/shared/utils/utils.dart';
import 'package:open_art/shared/widgets/space.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget snackBar(
    {BuildContext context,
    String message,
    Color bgColor = Colors.green,
    int duration = 2}) {
  return SnackBar(
    backgroundColor: bgColor,
    content: new Text(
      message,
      style: TextStyle(
        fontFamily: "Avenir",
        fontWeight: FontWeight.w700,
        fontSize: deviceWidth(context) / 30,
        color: Colors.white,
      ),
    ),
    duration: Duration(seconds: duration),
  );
}
