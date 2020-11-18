import 'package:flutter/material.dart';

/// 设备尺寸适配
class FitSize {
  /// 上下文
  BuildContext context;

  /// 字体缩放
  bool fontScaling;

  /// 设计图 宽 --> px
  double designWidth;

  /// 设计图 高 --> px
  double designHeight;

  FitSize({
    @required this.context,
    this.designWidth = 750,
    this.designHeight = 1334,
    this.fontScaling = true,
  });

  /// 设置 -> 宽度px转换为当前设备宽度dp
  double w(double size) => size * this._scaleWidth;

  /// 设置 -> 高度px转换为当前设备高度dp
  double h(double size) => size * this._scaleHeight;

  /// 设置 -> 字体px转换为当前设备字体dp
  double f(double size) => this.fontScaling
      ? this.w(size)
      : this.h(size) / this.screen.textScaleFactor;

  /// 当前设备参数
  DeviceSize get screen {
    MediaQueryData system = MediaQuery.of(this.context);
    return DeviceSize(
      width: system.size.width,
      height: system.size.height,
      devicePixelRatio: system.devicePixelRatio,
      stateBarHeight: system.padding.top,
      textScaleFactor: system.textScaleFactor,
      bottomBarHeight: system.padding.bottom,
    );
  }

  /// 获取 -> 当前设备宽度dp
  get screenWidthDp => this.screen.width;

  /// 获取 -> 当前设备高度dp
  get screenHeightDp => this.screen.height;

  /// 获取 -> 当前设备像素密度
  get devicePixelRatio => this.screen.devicePixelRatio;

  /// 获取 -> 当前设备宽度px
  get screenWidthPX => this.screenWidthDp * this.devicePixelRatio;

  /// 获取 -> 当前设备高度px
  get screenHeightPX => this.screenHeightDp * this.devicePixelRatio;

  /// 获取 -> 设备顶部状态栏高度dp
  get stateBarHeight => this.screen.stateBarHeight;

  /// 获取 -> 设备底部标签栏高度dp
  get bottomBarHeight => this.screen.bottomBarHeight;

  /// 当前设备宽度dp与设计稿px比例
  get _scaleWidth => this.screenWidthDp / this.designWidth;

  /// 当前设备高度dp与设计稿px比例
  get _scaleHeight => this.screenHeightDp / this.designHeight;
}

class DeviceSize {
  double width;
  double height;
  double devicePixelRatio;
  double stateBarHeight;
  double textScaleFactor;
  double bottomBarHeight;
  DeviceSize({
    this.width,
    this.height,
    this.devicePixelRatio,
    this.stateBarHeight,
    this.textScaleFactor,
    this.bottomBarHeight,
  });
}
