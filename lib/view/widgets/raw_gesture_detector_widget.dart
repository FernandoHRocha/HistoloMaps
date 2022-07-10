import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nandorocha_histologia/core/viewmodels/hitolomap_model.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import '../shared/global.dart';

class RemoveScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class DragAndScale extends ScaleGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}

class RawGestureDetectorWidget extends StatelessWidget {
  final Widget child;

  RawGestureDetectorWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HistoloMapModel>(context);
    final Size size = MediaQuery.of(context).size;

    final _gestures = {
      DragAndScale: GestureRecognizerFactoryWithHandlers<DragAndScale>(
        () => DragAndScale(),
        (DragAndScale instance) {
          instance
            ..onStart = (details) {
              model.handleDragScaleStart(details);
            }
            ..onUpdate = (details) {
              model.handleDragScaleUpdate(details);
            }
            ..onEnd = (_) {
              model.handleDragScaleEnd();
            };
        },
      )
    };

    final AlignmentGeometry _alignment = FractionalOffset.fromOffsetAndRect(
      Offset(
        size.width / 2.0,
        size.height / 2.0,
      ),
      Rect.fromLTRB(
        0.0,
        0.0,
        size.width,
        size.height,
      ),
    );

    final Matrix4 _transform = Matrix4.diagonal3(
      Vector3(
        model.scale,
        model.scale,
        model.scale,
      ),
    )..translate(
        model.pos.x,
        model.pos.y,
      );

    return RawGestureDetector(
      gestures: _gestures,
      child: Container(
        color: Colors.green,
        child: Transform(
          alignment: _alignment,
          transform: _transform,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
