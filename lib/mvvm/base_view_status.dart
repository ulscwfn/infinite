import 'package:flutter/cupertino.dart';

/// 挂载模块
import '../ui/ui.dart' show UI;

/// 页面 - 状态管理 - 基类
abstract class BaseViewStatus with ChangeNotifier {
  /// 页面实例上下文
  BuildContext ctx;

  /// 页面初始化
  @protected
  void load();

  /// 交互
  @protected
  UI ui;

  /// 页面路由参数
  @protected
  dynamic paramet;

  BaseViewStatus(BuildContext context) {
    ctx = context;
    ui = UI(context: ctx);
    paramet = ModalRoute.of(ctx).settings.arguments;
    load?.call();
  }
}
