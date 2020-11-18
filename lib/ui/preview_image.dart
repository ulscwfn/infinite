/* 
 * 预览图片
 */

import 'package:flutter/material.dart';

class PreviewImage extends StatefulWidget {
  final Widget image;

  PreviewImage(this.image);

  @override
  _PreviewImageState createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  Offset _start,
      _offset = Offset(0.0, 0.0),
      _end = Offset(0.0, 0.0),
      _offsetScale = Offset(0.0, 0.0),
      _offsetEndScale = Offset(0.0, 0.0),
      _initPoint = Offset(0.0, 0.0);
  double _scale = 1.0, _lastScale = 1.0;
  bool _isEnd = false; //

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: GestureDetector(
          onScaleStart: _handleOnScaleStart,
          onScaleUpdate: _handleOnScaleUpdate,
          onScaleEnd: _handleOnScaleEnd,
          child: _transform(),
        ),
      ),
    );
  }

  Offset temp;

  _transform() {
    temp = _isEnd
        ? _offsetEndScale
        : _offsetEndScale -
            _offsetScale; // _isEnd 主要是解决 _handleOnScaleEnd 异步的问题
    // print(
    //     "temp--=$temp offsetEndScale=$_offsetEndScale offsetScale=$_offsetScale scale=$_scale");
    return Transform(
      transform: new Matrix4.identity()
        ..translate(temp.dx, temp.dy)
        ..scale(_scale, _scale),

      /*  ..translate(-72.8 - 309.3 / 2, -386.3 - 630.3 / 2)
        ..scale(3.0, 3.0)
      ,*/

      child: this.widget.image,
    );
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    _start = details.focalPoint;
    preFocalPoint = Offset(0.0, 0.0);
  }

  Offset preFocalPoint = Offset(0.0, 0.0);
  Offset deltaPoint = Offset(0.0, 0.0);

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    if (isNeedAmpligy(details)) {
      amplify(details);
    } else if (isNeedNarrow(details)) {
      narrow(details);
    } else if (isNeedMove(details)) {
      move(details);
    }
  }

  bool isNeedMove(ScaleUpdateDetails details) => details.scale == 1.0;

  bool isNeedNarrow(ScaleUpdateDetails details) =>
      _scale > _getChangedScale(details);

  bool isNeedAmpligy(ScaleUpdateDetails details) =>
      _scale < _getChangedScale(details) &&
      (_scale - _getChangedScale(details)).abs() > 0.1;

  void amplify(ScaleUpdateDetails details) {
    // print("_handleOnScaleUpdate amplify ${details.focalPoint}");
    //      print("temp ${details.scale}");
    _isEnd = false;
    _scale += 0.1;
    _offsetScale =
        (_start - _initPoint) * _scale / _lastScale - (_start - _initPoint);
    //      print("temp offsetScale=$_offsetScale initPoint$_initPoint scale=$_scale");
    setState(() {});
  }

  void narrow(ScaleUpdateDetails details) {
    // print("_handleOnScaleUpdate narrow ${details.focalPoint}");
    _isEnd = false;
    _scale -= 0.2;
    if (_scale < 1.0) {
      _scale = 1.0;
    }
    //      print("temp lastScale=$_lastScale scale=$_scale");
    if (_lastScale - 1 == 0)
      _offsetScale = Offset(0.0, 0.0);
    else
      _offsetScale = _initPoint - _initPoint * (_scale - 1) / (_lastScale - 1);
    setState(() {});
  }

  void move(ScaleUpdateDetails details) {
    if (preFocalPoint.dx != 0.0 && preFocalPoint.dy != 0.0) {
      deltaPoint = details.focalPoint - preFocalPoint;
      if (deltaPoint.dx > 5 || deltaPoint.dy > 5) {
        _isEnd = false;
        _offsetScale -= deltaPoint;
        // print(
        //     "_handleOnScaleUpdate move $deltaPoint ${details.focalPoint} $preFocalPoint");
        setState(() {});
      }
    }
    if (deltaPoint.dx > 5 ||
        deltaPoint.dy > 5 ||
        (preFocalPoint.dx == 0.0 && preFocalPoint.dy == 0.0))
      preFocalPoint = details.focalPoint;
  }

  double _getChangedScale(ScaleUpdateDetails details) {
    double scale = details.scale - 1.0 + _lastScale;
    return scale;
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    _end = _getEnd();
    _lastScale = _scale;
    if (_isEnd == false) {
      _isEnd = true;
      _offsetEndScale -= _offsetScale;
      _initPoint = _offsetEndScale;
      _offsetScale = Offset(0.0, 0.0);
      preFocalPoint = Offset(0.0, 0.0);
    }
  }

  Offset _getEnd() => _end + _offset - _offsetScale;
}
