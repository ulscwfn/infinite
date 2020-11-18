import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension TextExt on Text {
  /// set modify style - 修改装饰 Text.style
  Text setStyle({
    bool inherit = true,
    Color color,
    Color backgroundColor,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextBaseline textBaseline,
    double height,
    Locale locale,
    Paint foreground,
    Paint background,
    List<Shadow> shadows,
    List<FontFeature> fontFeatures,
    TextDecoration decoration,
    Color decorationColor,
    TextDecorationStyle decorationStyle,
    double decorationThickness,
    String debugLabel,
    String fontFamily,
    List<String> fontFamilyFallback,
    String package,
    TextStyle theme,
  }) {
    return Text(
      data,
      key: key,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      strutStyle: strutStyle,
      textDirection: textDirection,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textScaleFactor: textScaleFactor,
      textHeightBehavior: textHeightBehavior,
      style: theme ??
          TextStyle(
            inherit: inherit,
            color: color,
            backgroundColor: backgroundColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            textBaseline: textBaseline,
            height: height,
            locale: locale,
            foreground: foreground,
            background: background,
            shadows: shadows,
            fontFeatures: fontFeatures,
            decoration: decoration,
            decorationColor: decorationColor,
            decorationStyle: decorationStyle,
            decorationThickness: decorationThickness,
            debugLabel: debugLabel,
            fontFamily: fontFamily,
            fontFamilyFallback: fontFamilyFallback,
            package: package,
          ),
    );
  }
}
