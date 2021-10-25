import 'package:flutter/material.dart';
import 'package:open_art/shared/utils/themes/theme.dart';

class FWt {
  FWt();

  static FontWeight extraLight = FontWeight.w200;
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight semiBold = FontWeight.w500;
  static FontWeight mediumBold = FontWeight.w600;

  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight text = FontWeight.w900;
}

class Styles {
  static Text regular(
    String text, {
    double fontSize,
    Color color,
    TextAlign align,
    double height,
    FontStyle fontStyle,
    FontWeight fontWeight,
    bool strike = false,
    int lines,
    TextOverflow overflow,
    bool underline = false,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        fontWeight: fontWeight ?? FWt.regular,
        color: color ?? pmTheme.text,
        height: height,
        fontStyle: fontStyle ?? null,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: 'Inter',
      ),
    );
  }

  static TextSpan spanRegular(
    String text, {
    double fontSize,
    Color color,
    TextAlign align,
    double height,
    FontStyle fontStyle,
    FontWeight fontWeight,
    bool strike = false,
    int lines,
    TextOverflow overflow,
    bool underline = false,
  }) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        fontWeight: fontWeight ?? FWt.regular,
        color: color ?? pmTheme.text,
        height: height,
        fontStyle: fontStyle ?? null,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: 'Inter',
      ),
    );
  }

  static Text medium(
    String text, {
    double fontSize,
    FontWeight fontWeight,
    Color color,
    TextAlign align,
    double height,
    bool strike = false,
    int lines,
    TextOverflow overflow,
    bool underline = false,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 14.0,
        fontWeight: fontWeight ?? FWt.mediumBold,
        color: color ?? pmTheme.text,
        height: height,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: 'Inter',
      ),
    );
  }

  static Text semiBold(
    String text, {
    double fontSize,
    Color color,
    TextOverflow overflow,
    TextAlign align,
    double height,
    bool strike = false,
    bool underline = false,
    int lines,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 16.0,
        fontWeight: FWt.semiBold,
        color: color ?? pmTheme.lowerText,
        height: height,
        decoration: underline
            ? TextDecoration.underline
            : strike
                ? TextDecoration.lineThrough
                : TextDecoration.none,
        fontFamily: 'Inter',
      ),
    );
  }

  static TextSpan spanBold(
    String text, {
    double fontSize,
    Color color,
    TextAlign align,
    bool strike = false,
    int lines,
    TextOverflow overflow,
    double height,
  }) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize ?? 18.0,
        fontWeight: FWt.bold,
        color: color ?? pmTheme.lowerText,
        height: height,
        decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
        fontFamily: 'Inter',
      ),
    );
  }

  static Text bold(
    String text, {
    double fontSize,
    Color color,
    TextAlign align,
    bool strike = false,
    int lines,
    TextOverflow overflow,
    double height,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 18.0,
        fontWeight: FWt.bold,
        color: color ?? pmTheme.lowerText,
        height: height,
        decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
        fontFamily: 'Inter',
      ),
    );
  }

  static Text extraBold(
    String text, {
    double fontSize,
    Color color,
    TextAlign align,
    int lines,
    bool strike = false,
    TextOverflow overflow,
  }) {
    return Text(
      text,
      textAlign: align ?? TextAlign.left,
      maxLines: lines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize ?? 20.0,
        fontWeight: FWt.extraBold,
        color: color ?? pmTheme.text,
        decoration: strike ? TextDecoration.lineThrough : TextDecoration.none,
        fontFamily: 'Inter',
      ),
    );
  }
}
