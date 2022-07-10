import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HistoloMapModel model = Provider.of<HistoloMapModel>(context);
    final Size size = MediaQuery.of(context).size;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _images.length,
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
              child: Image.asset(_images[index]),
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
                            const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 2,
                            ),
                            Center(
                              child: Icon(
                                Icons.add,
                                color: tilePlaces[idx].status
                                    ? Colors.indigo
                                    : Global.pink,
                                size: 7,
                              ),
                            ),
                            Transform(
                              transform: Matrix4.identity()..translate(0.0, 8),
                              child: Text(
                                tilePlaces[idx].name,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 4,
                                ),
                              ),
                            )
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
