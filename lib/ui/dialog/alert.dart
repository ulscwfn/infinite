import 'package:flutter/material.dart';
import '../../tools/fit_size.dart';

/// 原生对话框
class Alert extends StatefulWidget {
  final String title;
  final String content;
  final BuildContext ctx;
  final String continueText;
  final void Function(Function don) onContinue;

  Alert(
    this.ctx, {
    this.title,
    this.content,
    this.onContinue,
    this.continueText,
  });

  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  bool isLoad = false;

  void onContinue() {
    setState(() => isLoad = true);
    widget.onContinue?.call(don);
  }

  void don() {
    Navigator.pop(widget.ctx, false);
  }

  FitSize size;
  @override
  void initState() {
    size = FitSize(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "${widget.title}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "${widget.content}",
        style: TextStyle(fontSize: size.f(28.0), color: Colors.black54),
      ),
      actions: [
        isLoad
            ? Container()
            : FlatButton(
                onPressed: () => Navigator.pop(widget.ctx, false),
                child: Text(
                  "取消",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: size.f(28.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        FlatButton(
          onPressed: onContinue,
          child: isLoad
              ? Row(
                  children: [
                    Container(
                      width: size.w(28.0),
                      height: size.w(28.0),
                      child: CircularProgressIndicator(strokeWidth: 3),
                    ),
                    Text(
                      '   執行中...',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: size.f(24.0),
                      ),
                    )
                  ],
                )
              : Text(
                  "${widget.continueText}",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: size.f(28.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
        )
      ],
    );
  }
}
