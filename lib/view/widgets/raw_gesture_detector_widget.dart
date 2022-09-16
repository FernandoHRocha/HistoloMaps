import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nandorocha_histologia/core/models/models.dart';
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

class RawGestureDetectorWidget extends StatefulWidget {
  const RawGestureDetectorWidget();

  @override
  State<RawGestureDetectorWidget> createState() =>
      _RawGestureDetectorWidgetState();
}

class _RawGestureDetectorWidgetState extends State<RawGestureDetectorWidget> {
  List images = [];
  int _rowCount = 3;
  final sizes = {
    0: {
      'col': 7,
      'row': 3,
    },
    1: {
      'col': 14,
      'row': 6,
    },
  };

  rowCounts(level) {
    final _row = sizes[level]?['row'] ?? 3;
    return _row;
  }

  dirContents(level) async {
    List localImages = [];
    final _col = sizes[level]?['col'] ?? 7;
    final _row = sizes[level]?['row'] ?? 3;
    for (int col = 0; col <= _col; col++) {
      for (int row = 0; row <= _row; row++) {
        localImages.add(await DefaultAssetBundle.of(context)
            .load('assets/images/$level/l${col}_c$row.png'));
      }
    }
    return localImages;
  }

  @override
  void initState() {
    super.initState();
    const int level = 1;
    dirContents(level).then((value) => {
          setState(() {
            images = value;
            _rowCount = rowCounts(level);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HistoloMapModel>(context);
    final Size size = MediaQuery.of(context).size;

    rowCounts(level) {
      final _row = sizes[level]?['row'] ?? 3;
      return _row;
    }

    dirContents(level) async {
      List localImages = [];
      final _col = sizes[level]?['col'] ?? 7;
      final _row = sizes[level]?['row'] ?? 3;
      for (int col = 0; col <= _col; col++) {
        for (int row = 0; row <= _row; row++) {
          localImages.add(await DefaultAssetBundle.of(context)
              .load('assets/images/$level/l${col}_c$row.png'));
        }
      }
      return localImages;
    }

    final _gestures = {
      DragAndScale: GestureRecognizerFactoryWithHandlers<DragAndScale>(
        () => DragAndScale(),
        (DragAndScale instance) {
          instance
            ..onStart = (details) {
              model.handleDragScaleStart(details);
            }
            ..onUpdate = (details) {
              model.handleDragScaleUpdate(details, context);
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
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _rowCount + 1,
                ),
                //physics: const NeverScrollableScrollPhysics(),
                itemCount: images.length,
                clipBehavior: Clip.none,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  int currentTile = index + 1;
                  List<Place> tilePlaces = model.places
                      .where((item) => item.tile == currentTile)
                      .toList();
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2 / model.scale,
                          ),
                        ),
                        child: Image.memory(
                          images[index].buffer.asUint8List(),
                        ),
                      ),
                      model.isScaled
                          ? Stack(
                              children: List.generate(tilePlaces.length, (idx) {
                                return Transform.translate(
                                  offset: Offset(
                                    size.width * tilePlaces[idx].position[0],
                                    size.width * tilePlaces[idx].position[1],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      MaterialButton(
                                        shape: const CircleBorder(),
                                        height: 40 / model.scale,
                                        color: (Global.pink),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          print(tilePlaces[idx].name);
                                        },
                                        child: Text(
                                          tilePlaces[idx].name,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14 / model.scale,
                                          ),
                                        ),
                                      ),
                                      // Transform(
                                      //   alignment: Alignment.center,
                                      //   transform: Matrix4.identity()
                                      //     ..translate(0.0, 0 * 24 / model.scale),
                                      //   child: Text(
                                      //     tilePlaces[idx].name,
                                      //     style: TextStyle(
                                      //       color: Colors.black,
                                      //       fontSize: (24 * (1 / model.scale)),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                );
                              }),
                            )
                          : CircleAvatar(
                              backgroundColor: Global.pink,
                              child: Text(
                                tilePlaces.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
