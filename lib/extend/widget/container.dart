import 'package:flutter/material.dart';

/// Container extension
extension ContainerExt on Container {
  /// set modify Decoration - 修改装饰Container.decoration
  Container setDecoration({
    Color color,
    DecorationImage image,
    BoxBorder border,
    BorderRadiusGeometry borderRadius,
    List<BoxShadow> boxShadow,
    Gradient gradient,
    BlendMode backgroundBlendMode,
    BoxShape shape = BoxShape.rectangle,
    BoxDecoration decoration,
  }) {
    return Container(
      key: key,
      child: this,
      alignment: alignment,
      padding: padding,
      color: this.color,
      decoration: decoration ??
          BoxDecoration(
            color: color,
            image: image,
            border: border,
            borderRadius: borderRadius,
            boxShadow: boxShadow,
            gradient: gradient,
            backgroundBlendMode: backgroundBlendMode,
            shape: shape,
          ),
      foregroundDecoration: foregroundDecoration,
      constraints: constraints,
      margin: margin,
      transform: transform,
      clipBehavior: clipBehavior,
    );
  }
}
