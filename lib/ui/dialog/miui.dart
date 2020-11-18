import 'package:flutter/material.dart';
import '../../tools/fit_size.dart';

/// 仿MIUI对话框
class MiuiDialog extends StatelessWidget {
  final String title;
  final String message;
  final String cancelText;
  final String confirmText;

  MiuiDialog({
    this.title,
    this.message,
    this.cancelText,
    this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    var size = FitSize(context: context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.w(50.0),
        vertical: size.w(50.0),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(size.w(35.0))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: size.f(50.0),
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.w(15.0),
              vertical: size.h(40.0),
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: size.f(32.0),
                color: Color(0xff333333),
              ),
            ),
          ),
          Padding(padding: EdgeInsetsDirectional.only(top: size.h(20.0))),
          Row(
            children: [
              Expanded(
                child: Material(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),

                  /// f2f2f2 -> H:220,S:0%,B:95%,
                  color: Color(0xfff2f2f2),
                  child: InkWell(
                    onTap: () => Navigator.pop(context, false),
                    child: Container(
                      alignment: Alignment.center,
                      height: size.h(100.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      child: Text(
                        '$cancelText',
                        style: TextStyle(
                          fontSize: size.f(32.0),

                          /// 333333 -> H:220,S:0%,B:20%,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: size.w(50.0))),
              Expanded(
                child: Material(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),

                  /// ffe6eaf2 -> H:220,S:5%,B:95%,
                  color: Color(0xffe6eaf2),
                  child: InkWell(
                    onTap: () => Navigator.pop(context, true),
                    child: Container(
                      alignment: Alignment.center,
                      height: size.h(100.0),
                      child: Text(
                        '$confirmText',
                        style: TextStyle(
                          /// 3377ff -> H:220,S:80%,B:100%,
                          color: Color(0xff3377ff),
                          fontSize: size.f(32.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MiuiDialogLoad extends StatelessWidget {
  final String message;
  final String loadText;
  final void Function(Function done) load;
  MiuiDialogLoad({this.load, this.message, this.loadText});

  @override
  Widget build(BuildContext context) {
    var size = FitSize(context: context);

    /// 外层控制关闭
    load?.call(() => Navigator.pop(context, false));

    return WillPopScope(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.w(50.0),
          vertical: size.w(50.0),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(size.w(35.0))),
        ),
        child: Row(
          children: [
            Container(
              width: 14,
              height: 14,
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: CircularProgressIndicator(strokeWidth: 3.5),
            ),
            Text(
              loadText,
              style: TextStyle(
                fontSize: size.f(30.0),
              ),
            )
          ],
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
