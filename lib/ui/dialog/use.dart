import 'package:flutter/material.dart';

import 'alert.dart';
import 'miui.dart';

enum LoadButton { cancel, confirm }

class Dialogs {
  BuildContext context;

  Dialogs({this.context});

  /// 仿miui 对话框
  Future<bool> miui({
    String title = '标题',
    String cancelText = '取消',
    String message = '信息内容',
    String confirmText = '确定',
    String loadText = '正在加载中...',
    void Function(Function done) onLoad,
    LoadButton loadButton = LoadButton.confirm,
  }) async {
    var res = await showModalBottomSheet<bool>(
      context: context,
      elevation: 0,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      barrierColor: Color.fromRGBO(0, 0, 0, 0.3),
      builder: (_) => MiuiDialog(
        title: title,
        message: message,
        cancelText: cancelText,
        confirmText: confirmText,
      ),
    );

    LoadButton resVlue = res ? LoadButton.confirm : LoadButton.cancel;

    if (onLoad != null && resVlue == loadButton) {
      await showModalBottomSheet<bool>(
        context: context,
        elevation: 0,
        enableDrag: false,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        barrierColor: Color.fromRGBO(0, 0, 0, 0.3),
        builder: (_) => MiuiDialogLoad(
          message: message,
          load: onLoad,
          loadText: loadText,
        ),
      );
    }
    return res;
  }

  /// 原生对话框
  Future<bool> alert({
    String title,
    String continueText,
    @required String content,
    void Function(Function don) onContinue,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Alert(
        _,
        title: title,
        content: content,
        onContinue: onContinue,
        continueText: continueText,
      ),
    );
  }
}
