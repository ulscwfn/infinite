import 'package:flutter/material.dart';

import './dialog/use.dart';
import './message/use.dart';
import './action_sheet.dart';

/// 基础ui组件
class UI {
  BuildContext context;

  UI({this.context});
  Dialogs get dialog => Dialogs(context: context);

  Message get message => Message(context: context);

  Future<SheetButton> actionSheet({
    List<SheetButton> list = const [],
    WrapAlignment alignment = WrapAlignment.start,
  }) {
    return showModalBottomSheet<SheetButton>(
      context: context,
      elevation: 0,
      enableDrag: false,
//      isDismissible: false,
      backgroundColor: Colors.transparent,
      barrierColor: Color.fromRGBO(0, 0, 0, 0.3),
      builder: (_) => ActionSheet(list: list, alignment: alignment),
    );
  }
}
