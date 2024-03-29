import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nandorocha_histologia/core/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:nandorocha_histologia/view/shared/global.dart';

class Pos {
  double x = 0.0;
  double y = 0.0;

  Pos(x, y) {
    this.x = x;
    this.y = y;
  }
}

class HistoloMapModel extends ChangeNotifier {
  final double MAX_SCALE = 128.0;
  double _scale = 1.0;
  double _previousScale = 1.0;
  Pos _pos = Pos(0.0, 0.0);
  Pos _previousPos = Pos(0.0, 0.0);
  Pos _endPos = Pos(0.0, 0.0);
  bool _isScaled = false;

  double get scale => _scale;
  double get previousScale => _previousScale;
  Pos get pos => _pos;
  Pos get previousPos => _previousPos;
  Pos get endPos => _endPos;
  bool get isScaled => _isScaled;

  bool _hasTouched = false;
  bool get hasTouched => _hasTouched;
  set hasTouched(value) {
    _hasTouched = value;
    notifyListeners();
  }

  final List<Place> _place =
      Global.places.map((item) => Place.fromMap(item)).toList();
  List<Place> get places => _place;

  void handleDragScaleStart(ScaleStartDetails details) {
    _hasTouched = true;
    _previousScale = _scale;
    _previousPos.x = (details.focalPoint.dx / _scale) - _endPos.x;
    _previousPos.y = (details.focalPoint.dy / _scale) - _endPos.y;
    notifyListeners();
  }

  void handleDragScaleUpdate(ScaleUpdateDetails details, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 20;
    double screenHeight = MediaQuery.of(context).size.height - 103;

    void limitDrag() {
      double rightLimit = (screenWidth / 2) - ((screenWidth / (2 * _scale)));
      double downLimit = ((screenHeight * (1 - (1 / _scale))) / 2);

      if (_pos.x > rightLimit) {
        _pos.x = rightLimit;
      }

      if (_pos.y > downLimit) {
        _pos.y = downLimit;
      }
    }

    void scaleFunctions() {
      _scale = _previousScale * details.scale;
      if (_scale > 2.0) {
        _isScaled = true;
      } else {
        _isScaled = false;
      }

      if (_scale < 1.0) {
        _scale = 1.0;
      } else if (_scale > MAX_SCALE) {
        _scale = MAX_SCALE;
      } else if (_previousScale == _scale) {
        _pos.x = (details.focalPoint.dx / _scale) - _previousPos.x;
        _pos.y = (details.focalPoint.dy / _scale) - _previousPos.y;
      }
    }

    scaleFunctions();
    limitDrag();

    notifyListeners();
  }

  void reset() {
    _scale = 1.0;
    _previousScale = 1.0;
    _pos = Pos(0.0, 0.0);
    _previousPos = Pos(0.0, 0.0);
    _endPos = Pos(0.0, 0.0);
    _isScaled = false;
    notifyListeners();
  }

  void handleDragScaleEnd() {
    _previousScale = 2.0;
    _endPos = _pos;
    notifyListeners();
  }
}
