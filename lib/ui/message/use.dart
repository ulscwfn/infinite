import 'dart:async';
import 'package:flutter/material.dart';

import './success.dart';
import './toase.dart';
import './loading.dart';

/// 提示消息
class Message {
  BuildContext context;

  Message({this.context});

  /// 成功消息提示
  Future success({
    @required String title,
    double size = 210.0,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return Center(
          child: Container(
            width: 150.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: SuccessMessage(
              size: size,
              title: title,
              onCompleted: () => Navigator.of(ctx).pop(),
            ),
          ),
        );
      },
    );
  }

  OverlayEntry _overlayEntry; // 实例
  /// 消息提示
  Future<bool> toase({
    int waitingTime = 1000,
    @required String message,
    ToaseTheme theme = ToaseTheme.dark,
    Alignment position = Alignment.bottomCenter,
  }) async {
    int animationTime = 1500;
    Completer<bool> c = Completer();
    OverlayState overlayState = Overlay.of(context);
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (_) => Toase(
          theme: theme,
          message: message,
          position: position,
          waitingTime: waitingTime,
          animationTime: animationTime,
          onEnd: () {
            _overlayEntry.markNeedsBuild();
            _overlayEntry.remove();
            _overlayEntry = null;
            c.complete(true);
          },
        ),
      );
      overlayState.insert(_overlayEntry);
    } else {
      _overlayEntry?.markNeedsBuild();
      c.complete(false);
    }
    return c.future;
  }

  /// 加载动画 - 手动关闭
  Future<bool> loading({
    String message = '正在加载中...',
    void Function(Function done) onComplete,
  }) {
    OverlayState overlayState = Overlay.of(context);
    var res = Completer<bool>();
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
          builder: (_) => Loading(
                message: message,
                onComplete: (close) {
                  onComplete?.call(() async {
                    await close();
                    _overlayEntry.markNeedsBuild();
                    _overlayEntry.remove();
                    _overlayEntry = null;
                    res.complete(true);
                  });
                },
              ));
      overlayState.insert(_overlayEntry);
    } else {
      _overlayEntry?.markNeedsBuild();
      res.complete(false);
    }
    return res.future;
  }
}
