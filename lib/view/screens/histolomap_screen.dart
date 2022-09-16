import 'package:flutter/material.dart';
import 'package:nandorocha_histologia/view/widgets/appbar_widget.dart';
import 'package:nandorocha_histologia/view/widgets/raw_gesture_detector_widget.dart';

class HistoloMapScreen extends StatelessWidget {
  const HistoloMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        child: RawGestureDetectorWidget(),
      ),
    );
  }
}
