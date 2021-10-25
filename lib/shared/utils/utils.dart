export 'config.dart';
export 'dims.dart';
export 'styles.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String capitalizeText(String text, {bool eachWord}) {
  if (text == null) {
    return null;
  } else if (text.length <= 1) {
    return text.toUpperCase();
  } else {
    final List<String> list = text.split('');
    list[0] = list[0].toUpperCase();

    if (eachWord == true) {
      for (int i = 1; i < text.length; i++) {
        if (list[i] == ' ') {
          list[i + 1] = list[i + 1].toUpperCase();
        }
      }
    }

    return list.join('');
  }
}

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

String formatDate(DateTime dateTime) {
  return DateFormat('dd MMM yyyy').format(dateTime);
}

String formatTime(DateTime dateTime) {
  return DateFormat('HH:mm').format(dateTime);
}

String formatDateApi(DateTime dateTime) {
  return DateFormat('yyyy-mm-dd').format(dateTime);
}

///design height(responsiveness)
double logicalHeight() {
  return WidgetsBinding.instance.window.physicalSize.height /
      WidgetsBinding.instance.window.devicePixelRatio;
}

///design width(responsiveness)
double logicalWidth() {
  return WidgetsBinding.instance.window.physicalSize.width /
      WidgetsBinding.instance.window.devicePixelRatio;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}