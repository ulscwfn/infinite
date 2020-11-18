import 'package:flutter/material.dart';
import '../../tools/fit_size.dart';

/// 普通消息提示
class Toase extends StatefulWidget {
  final String message;
  final Alignment position;
  final int waitingTime;
  final int animationTime;
  final ToaseTheme theme;
  final void Function() onEnd;

  Toase({
    this.message,
    this.theme,
    this.waitingTime,
    this.position,
    this.animationTime,
    this.onEnd,
  });

  @override
  _ToaseState createState() => _ToaseState();
}

class _ToaseState extends State<Toase> with TickerProviderStateMixin {
  AnimationController animationController;
  CurvedAnimation opacity, scale;

  ToaseType get themeColor => ToaseType(widget.theme);

  FitSize size;
  @override
  void initState() {
    size = FitSize(context: context);
    this.animationCreate();
    this.animationImplement();
    super.initState();
  }

  /// 创建动画
  void animationCreate() {
    animationController = AnimationController(
      value: 0.2,
      vsync: this,
      duration: Duration(milliseconds: widget.animationTime),
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

  /// 执行动画
  void animationImplement() async {
    /// 开始动画
    await animationController.forward();

    /// 修改动画时间,旋转，透明度
    animationController.duration = Duration(milliseconds: 1000);
    scale.curve = Curves.elasticOut;
    opacity.curve = Curves.easeOutQuart;

    /// 等待时间 -> 逆转结束动画
    await Future.delayed(Duration(milliseconds: widget.waitingTime));
    await animationController.reverse();
    widget.onEnd?.call();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Alignment get _alig {
    Alignment als;
    if (widget.position.y > 0) {
      als = widget.position.add(Alignment(0, 0.06));
    } else if (widget.position.y < 0) {
      als = widget.position.add(Alignment(0, -0.06));
    } else {
      als = widget.position;
    }
    return als;
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
            alignment: widget.position,
            child: MediaQuery.removeViewInsets(
              removeTop: true,
              removeLeft: true,
              removeRight: true,
              removeBottom: true,
              context: context,
              child: Align(
                alignment: this._alig,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.w(60.0)),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: themeColor.bgColor,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    border: Border.all(
                      width: size.w(1.0),
                      color: themeColor.borderColor,
                    ),
                    // boxShadow: [
                    // BoxShadow(color: Colors.black12, blurRadius: 10),
                    // ],
                  ),
                  child: Text(
                    widget.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.f(24.0),
                      color: themeColor.textColor,
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

enum ToaseTheme { dark, bright }

class ToaseType {
  ToaseTheme type;
  Color bgColor;
  Color textColor;
  Color borderColor;

  ToaseType(this.type) {
    switch (this.type) {
      case ToaseTheme.dark:
        this.bgColor = Colors.black;
        this.textColor = Colors.white;
        this.borderColor = Colors.black;
        break;
      case ToaseTheme.bright:
        this.bgColor = Colors.white;
        this.textColor = Colors.black;
        this.borderColor = Color(0xff999999);
        break;
      default:
    }
  }
}
