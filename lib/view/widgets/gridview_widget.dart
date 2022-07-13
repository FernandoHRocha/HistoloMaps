import 'package:flutter/material.dart';
import 'package:nandorocha_histologia/core/models/models.dart';
import 'package:nandorocha_histologia/core/viewmodels/hitolomap_model.dart';
import 'package:provider/provider.dart';

import '../shared/global.dart';

List<String> _images = [
  'assets/images/l0_c0.png',
  'assets/images/l0_c1.png',
  'assets/images/l0_c2.png',
  'assets/images/l0_c3.png',
  'assets/images/l1_c0.png',
  'assets/images/l1_c1.png',
  'assets/images/l1_c2.png',
  'assets/images/l1_c3.png',
  'assets/images/l2_c0.png',
  'assets/images/l2_c1.png',
  'assets/images/l2_c2.png',
  'assets/images/l2_c3.png',
  'assets/images/l3_c0.png',
  'assets/images/l3_c1.png',
  'assets/images/l3_c2.png',
  'assets/images/l3_c3.png',
  'assets/images/l4_c0.png',
  'assets/images/l4_c1.png',
  'assets/images/l4_c2.png',
  'assets/images/l4_c3.png',
  'assets/images/l5_c0.png',
  'assets/images/l5_c1.png',
  'assets/images/l5_c2.png',
  'assets/images/l5_c3.png',
  'assets/images/l5_c0.png',
  'assets/images/l5_c1.png',
  'assets/images/l5_c2.png',
  'assets/images/l5_c3.png',
  'assets/images/l6_c0.png',
  'assets/images/l6_c1.png',
  'assets/images/l6_c2.png',
  'assets/images/l6_c3.png',
  'assets/images/l7_c0.png',
  'assets/images/l7_c1.png',
  'assets/images/l7_c2.png',
  'assets/images/l7_c3.png'
];

class GridViewStatefulWidget extends StatefulWidget {
  const GridViewStatefulWidget({Key? key}) : super(key: key);

  @override
  _GridViewStatefulWidget createState() => _GridViewStatefulWidget();
}

class _GridViewStatefulWidget extends State<GridViewStatefulWidget> {
  List images0 = [];
  List images1 = [];
  // int _col = 14;
  // int _row = 6;
  final int _col = 7;
  final int _row = 3;

  @override
  void initState() {
    super.initState();
    dirContents(0).then((value) => {
          setState(() {
            images0 = value;
          })
        });
  }

  dirContents(level) async {
    List localImages = [];
    for (int col = 0; col <= _col; col++) {
      for (int row = 0; row <= _row; row++) {
        localImages.add(await DefaultAssetBundle.of(context)
            .load('assets/images/$level/l${col}_c$row.png'));
      }
    }
    return localImages;
  }

  @override
  Widget build(BuildContext context) {
    final HistoloMapModel model = Provider.of<HistoloMapModel>(context);
    final Size size = MediaQuery.of(context).size;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _row + 1,
      ),
      //physics: const NeverScrollableScrollPhysics(),
      itemCount: images0.length,
      clipBehavior: Clip.none,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        int currentTile = index + 1;
        List<Place> tilePlaces =
            model.places.where((item) => item.tile == currentTile).toList();
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
                images0[index].buffer.asUint8List(),
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
    );
  }
}
