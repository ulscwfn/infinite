import 'dart:async';

import 'package:flutter/material.dart';
import '../../tools/fit_size.dart';

/// 加载动画
class Loading extends StatefulWidget {
  final String message;
  final void Function(Future<bool> Function()) onComplete;

  Loading({
    this.message,
    this.onComplete,
  });

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  AnimationController animationController;

  /// 动画
  CurvedAnimation opacity, scale;
  bool show = false;

  FitSize size;

  @override
  void initState() {
    size = FitSize(context: context);
    super.initState();
    this.animationCreate();
    this.animationImplement();
  }

  /// 创建动画
  void animationCreate() {
    animationController = AnimationController(
      value: 0.2,
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    scale = CurvedAnimation(
      curve: Curves.elasticInOut,
      parent: animationController,
    );

    opacity = CurvedAnimation(
      curve: Curves.easeInOut,
      parent: animationController,
    );
  }

  Future _closed() async {
    /// 修改动画时间,旋转，透明度
    animationController.duration = Duration(milliseconds: 1000);
    scale.curve = Curves.elasticOut;
    opacity.curve = Curves.easeOutQuart;

    /// 开始动画
    await animationController.reverse();
  }

  /// 执行动画
  void animationImplement() async {
    /// 等待外部调用关闭
    widget.onComplete?.call(() async {
      var res = Completer<bool>();
      if (show) {
        await _closed();
        res.complete(true);
      } else {
        Timer.periodic(Duration(milliseconds: 500), (timer) async {
          if (show) {
            /// 等待时间 -> 逆转结束动画
            timer?.cancel();
            await _closed();
            res.complete(true);
          }
        });
      }
      return res.future;
    });

    /// 开始动画
    await animationController.forward();
    setState(() => show = true);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 150.0),
        child: FadeTransition(
          opacity: opacity,
          child: ScaleTransition(
            scale: scale,
            alignment: Alignment.center,
            child: MediaQuery.removeViewInsets(
              removeTop: true,
              removeLeft: true,
              removeRight: true,
              removeBottom: true,
              context: context,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.w(60.0)),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    border: Border.all(
                      width: size.w(1.0),
                      color: Colors.black38,
                    ),
                  ),
                  child: Text(
                    widget.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.f(24.0),
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
