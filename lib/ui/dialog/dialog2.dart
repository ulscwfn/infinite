import 'package:flutter/material.dart';
import '../../tools/fit_size.dart';

Future<bool> showDialog2({BuildContext context, String title, String message}) {
  return showDialog<bool>(
    context: context,
    // elevation: 0,
    // enableDrag: false,
    // isDismissible: false,
    barrierColor: Color.fromRGBO(0, 0, 0, 0.3),
    // backgroundColor: Colors.transparent,
    builder: (_) => _DialogWidget(
      title: title,
      message: message,
    ),
  );
}

/*
 *  对话框 
 */
class _DialogWidget extends StatefulWidget {
  final String title;
  final String message;
  final void Function(void Function()) onConfirm;

  _DialogWidget({this.title, this.message, this.onConfirm});

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<_DialogWidget>
    with TickerProviderStateMixin {
  /// 动画时间
  int animationTime = 1000;
  AnimationController animationController;
  CurvedAnimation opacity, scale;

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
      vsync: this,
      duration: Duration(milliseconds: animationTime),
    );

    opacity = CurvedAnimation(
      curve: Curves.ease,
      parent: animationController,
    );

    scale = CurvedAnimation(
      curve: Curves.elasticInOut,
      parent: animationController,
    );
  }

  /// 执行动画
  void animationImplement() async {
    await animationController.forward();
    // await Future.delayed(Duration(milliseconds: widget.waitingTime));
    // await animationController.reverse();
    // widget.onEnd?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          FadeTransition(
            opacity: opacity,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color.fromRGBO(0, 0, 0, 0.4),
            ),
          ),
          // AlignTransition(alignment: null, child: null)
        ],
      ),
    );
  }
}
