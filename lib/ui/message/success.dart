import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../tools/fit_size.dart';

/// 成功消息
class SuccessMessage extends StatefulWidget {
  final Color color;
  final VoidCallback onCompleted;
  final String title;
  final double size;

  const SuccessMessage({
    Key key,
    this.color,
    this.onCompleted,
    this.title,
    this.size,
  }) : super(key: key);

  @override
  _SuccessMessageState createState() => _SuccessMessageState();
}

class _SuccessMessageState extends State<SuccessMessage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation opacity;
  FitSize size;
  @override
  void initState() {
    size = FitSize(context: context);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();
    _controller.addStatusListener((state) async {
      if (state == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 1500))
            .then((_) => widget.onCompleted());
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return _buildBody();
      },
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: size.w(widget.size),
          width: size.w(widget.size),
          padding: EdgeInsets.all(30.0),
          child: CustomPaint(
            painter: _SuccessMessagePainter(
              color: widget.color,
              value: _controller.value,
              line1StartValue: Tween(begin: 0.0, end: 0.5)
                  .transform(Interval(0.75, 1.0).transform(_controller.value)),
              line1EndValue: Interval(0.5, 0.75).transform(_controller.value),
              line2EndValue: Interval(0.75, 1.0).transform(_controller.value),
            ),
          ),
        ),
        Opacity(
            opacity: Tween(begin: 0.0, end: 1.0).transform(
              Interval(0.75, 1.0).transform(_controller.value),
            ),
//          child: Transform(
//            transform: Matrix4.rotationY(Tween(begin: 0.0, end: 1.0).transform(
//              Interval(0.75, 1.0).transform(_controller.value),
//            )),
//            child: Container(
//              alignment: Alignment.center,
//              padding: EdgeInsets.only(bottom: size.h(50.0)),
//              child: Text(
//                widget.title,
//                style: TextStyle(
//                  color: Colors.black87,
//                  decoration: TextDecoration.none,
//                  fontSize: size.f(30.0),
//                ),
//              ),
//            ),
//          ),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: size.h(50.0)),
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.black87,
                  decoration: TextDecoration.none,
                  fontSize: size.f(30.0),
                ),
              ),
            ))
      ],
    );
  }
}

class _SuccessMessagePainter extends CustomPainter {
  static final Offset _p1 = Offset(0.1, 0.45);
  static final Offset _p2 = Offset(0.45, 0.7);
  static final Offset _p3 = Offset(0.75, 0.35);

  final Color color;
  final double value;
  final double line1StartValue;
  final double line1EndValue;
  final double line2EndValue;

  final double _arcStart;
  final double _arcSweep;
  final Offset _line1Start;
  final Offset _line1End;
  final Offset _line2End;

  _SuccessMessagePainter({
    this.color,
    this.value,
    this.line1StartValue,
    this.line1EndValue,
    this.line2EndValue,
  })  : _arcStart = math.pi + math.pi * 2 * value * 2,
        _arcSweep = -value * math.pi * 2,
        _line1Start = _p1 - (_p1 - _p2) * line1StartValue,
        _line1End = _p1 - (_p1 - _p2) * line1EndValue,
        _line2End = _p2 - (_p2 - _p3) * line2EndValue;

  @override
  void paint(Canvas canvas, Size size) {
    double side = math.min(size.width, size.height);

    Paint paint = Paint()
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = color ?? Colors.blueAccent;

    if (_line1Start != _line1End) {
      canvas.drawLine(_line1Start * side, _line1End * side, paint);
    }
    if (_p2 != _line2End) {
      canvas.drawLine(_p2 * side, _line2End * side, paint);
    }
    canvas.drawArc(
        Offset.zero & Size(side, side), _arcStart, _arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(_SuccessMessagePainter other) => value != other.value;
}
