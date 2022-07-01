import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../shared/global.dart';

List<String> _images = [
  'assets/images/0_0.png',
  'assets/images/1_0.png',
  'assets/images/2_0.png',
  'assets/images/3_0.png',
  'assets/images/0_1.png',
  'assets/images/1_1.png',
  'assets/images/2_1.png',
  'assets/images/3_1.png',
  'assets/images/0_2.png',
  'assets/images/1_2.png',
  'assets/images/2_2.png',
  'assets/images/3_2.png',
  'assets/images/0_3.png',
  'assets/images/1_3.png',
  'assets/images/2_3.png',
  'assets/images/3_3.png',
  'assets/images/0_4.png',
  'assets/images/1_4.png',
  'assets/images/2_4.png',
  'assets/images/3_4.png',
  'assets/images/0_5.png',
  'assets/images/1_5.png',
  'assets/images/2_5.png',
  'assets/images/3_5.png',
  'assets/images/0_6.png',
  'assets/images/1_6.png',
  'assets/images/2_6.png',
  'assets/images/3_6.png',
  'assets/images/0_7.png',
  'assets/images/1_7.png',
  'assets/images/2_7.png',
  'assets/images/3_7.png'
];

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: _images.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          child: Image.asset(_images[index]),
        );
      },
    );
  }
}
