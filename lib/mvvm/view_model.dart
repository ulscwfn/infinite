import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// 数据模型 - 状态/方法/局部/创建
class ViewModel {
  static T value<T>(BuildContext ctx, {bool listen = true}) {
    return Provider.of<T>(ctx, listen: listen);
  }

  static T use<T>(BuildContext ctx, {bool listen = false}) {
    return Provider.of<T>(ctx, listen: listen);
  }

  static Consumer connect<T>(
    Widget Function(BuildContext, dynamic, Widget) build,
    Widget child,
  ) {
    return Consumer<T>(builder: build, child: child);
  }

  static ChangeNotifierProvider<T> create<T extends ChangeNotifier>({
    @required T status,
    Widget Function(BuildContext ctx, T status, Widget node) builder,
  }) {
    return ChangeNotifierProvider(
      create: (_) => status,
      child: Consumer<T>(builder: builder),
    );
  }
}
