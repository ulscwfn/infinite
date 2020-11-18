import 'package:flutter/material.dart';
import '../tools/fit_size.dart';

/// 上拉菜单
// ignore: must_be_immutable
class ActionSheet extends StatelessWidget {
  final List<SheetButton> list;
  final WrapAlignment alignment;

  ActionSheet({this.list, this.alignment});

  final int itemCol = 5; // item列数
  final double _boxRadius = 35.0; // 盒子圆角
  final double _boxDistance = 50.0; // 盒子总边距

  final double _itemRadius = 30.0; // item圆角
  final double _itemDistance = 30.0; // item的边距

  double get itemWidth {
    double distance = (itemCol - 1) * _itemDistance / itemCol;
    return (750 - _boxDistance * 2) / 5 - distance;
  }

  FitSize size;

  @override
  Widget build(BuildContext context) {
    size = FitSize(context: context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.w(_boxDistance),
        vertical: size.w(70.0),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(size.w(_boxRadius)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            child: Wrap(
              alignment: alignment,
              children: list.asMap().keys.map((index) {
                return itemSheet(context, index);
              }).toList(),
            ),
          ),
          cancelBtn(context),
        ],
      ),
    );
  }

  /// 菜单按钮
  Widget itemSheet(BuildContext ctx, int index) {
    bool isRight = (index == itemCol - 1) || (index == list.length - 1);
    return Padding(
      padding: EdgeInsets.only(
        right: isRight ? 0 : size.w(_itemDistance),
        bottom: size.h(20.0),
      ),
      child: Column(
        children: [
          Material(
//            color: Color(0xfff2f2f2),
            color: Color(0xfff5f5f5),
            clipBehavior: Clip.antiAlias,
            borderRadius:
                BorderRadius.all(Radius.circular(size.w(_itemRadius))),
            child: InkWell(
              onTap: () => Navigator.pop(ctx, list[index]),
              child: Container(
                width: size.w(itemWidth),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: list[index].icon,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.h(20.0)),
            child: Container(
              width: size.w(itemWidth),
              alignment: Alignment.center,
              child: Text(
                list[index].label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.f(26.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 取消按钮
  Widget cancelBtn(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.only(top: size.h(30.0)),
      child: Material(
        color: Color(0xfff5f5f5),
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(size.w(20.0))),
        child: InkWell(
          onTap: () => Navigator.pop(ctx, null),
          child: Container(
            padding: EdgeInsets.all(size.w(30.0)),
            alignment: Alignment.center,
            child: Text(
              '取消',
              style: TextStyle(
                fontSize: size.f(28.0),
                color: Color(0xff333333),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 菜单
class SheetButton {
  String value;
  String label;
  Widget icon;

  SheetButton({
    @required this.label,
    @required this.icon,
    @required this.value,
  });
}
